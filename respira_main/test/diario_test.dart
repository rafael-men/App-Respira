import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/widgets/gradient_button.dart';
import 'package:respira_main/features/diario/domain/registro_humor.dart';
import 'package:respira_main/features/diario/pages/historico_humor_page.dart';
import 'package:respira_main/features/diario/pages/registro_humor_page.dart';
import 'package:respira_main/features/main/pages/home_page.dart';
import 'package:respira_main/features/main/widgets/mood_selector.dart';

import 'suporte_sprint4.dart';

void main() {
  testWidgets('salvar sem humor fica desabilitado', (tester) async {
    await tester.pumpWidget(
      appTeste(Dependencias.memoria(), const RegistroHumorPage()),
    );
    expect(
      tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
      isNull,
    );
  });

  testWidgets('salvar com humor grava nota e retorna', (tester) async {
    final deps = Dependencias.memoria();
    await abrirTela(tester, deps, const RegistroHumorPage());
    await tester.tap(find.text('🙂'));
    await tester.enterText(find.byType(TextField), 'Um dia tranquilo');
    await tester.tap(find.text('Salvar registro'));
    await tester.pumpAndSettle();
    final registros = await deps.diario.observarRegistros().first;
    expect(registros.single.humor, NivelHumor.bem);
    expect(registros.single.nota, 'Um dia tranquilo');
    expect(find.byType(RegistroHumorPage), findsNothing);
    expect(find.text('Registro salvo.'), findsOneWidget);
  });

  testWidgets('humorInicial chega selecionado e pode ser salvo', (
    tester,
  ) async {
    await tester.pumpWidget(
      appTeste(
        Dependencias.memoria(),
        const RegistroHumorPage(humorInicial: NivelHumor.mal),
      ),
    );
    expect(
      tester.widget<MoodSelector>(find.byType(MoodSelector)).selecionado,
      1,
    );
    expect(
      tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('histórico usa ordem decrescente e mostra sem nota', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    await deps.diario.registrar(
      RegistroHumor(
        humor: NivelHumor.mal,
        nota: 'Antigo',
        criadoEm: DateTime(2026, 6, 23, 14, 5),
      ),
    );
    await deps.diario.registrar(
      RegistroHumor(
        humor: NivelHumor.bem,
        criadoEm: DateTime(2026, 6, 24, 8, 12),
      ),
    );
    await tester.pumpWidget(appTeste(deps, const HistoricoHumorPage()));
    await tester.pumpAndSettle();
    expect(find.text('(sem nota)'), findsOneWidget);
    expect(find.text('23/06, 14:05'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('(sem nota)')).dy,
      lessThan(tester.getTopLeft(find.text('Antigo')).dy),
    );
  });

  testWidgets('exclusão pede confirmação e respeita Cancelar', (tester) async {
    final deps = Dependencias.memoria();
    await deps.diario.registrar(RegistroHumor(humor: NivelHumor.neutro));
    await tester.pumpWidget(appTeste(deps, const HistoricoHumorPage()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('× excluir'));
    await tester.pumpAndSettle();
    expect(await deps.diario.observarRegistros().first, hasLength(1));
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(await deps.diario.observarRegistros().first, hasLength(1));
    await tester.tap(find.text('× excluir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    expect(await deps.diario.observarRegistros().first, isEmpty);
    expect(find.textContaining('Nenhum registro ainda.'), findsOneWidget);
  });

  testWidgets('contador aparece só quando faltam menos de 500 caracteres', (
    tester,
  ) async {
    await tester.pumpWidget(
      appTeste(Dependencias.memoria(), const RegistroHumorPage()),
    );
    await tester.enterText(find.byType(TextField), 'a' * 9500);
    await tester.pump();
    expect(find.textContaining('caracteres restantes'), findsNothing);
    await tester.enterText(find.byType(TextField), 'a' * 9501);
    await tester.pump();
    expect(find.text('499 caracteres restantes'), findsOneWidget);

    final notaNoLimite = 'a' * 9998 + '🙂';
    await tester.enterText(find.byType(TextField), notaNoLimite);
    await tester.pump();
    expect(find.text('0 caracteres restantes'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '${notaNoLimite}a');
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      notaNoLimite,
    );
  });

  testWidgets('tocar em humor na Início abre o diário com a seleção', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    await tester.pumpWidget(
      appTeste(deps, HomePage(authRepository: deps.auth)),
    );
    await tester.tap(find.text('😄'));
    await tester.pumpAndSettle();
    final pagina = tester.widget<RegistroHumorPage>(
      find.byType(RegistroHumorPage),
    );
    expect(pagina.humorInicial, NivelHumor.muitoBem);
  });
}
