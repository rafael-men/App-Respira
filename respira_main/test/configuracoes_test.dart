import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/configuracoes/data/lembretes_service.dart';
import 'package:respira_main/features/configuracoes/domain/configuracoes.dart';
import 'package:respira_main/features/configuracoes/pages/configuracoes_page.dart';
import 'package:respira_main/features/panico/pages/panico_page.dart';

import 'suporte_sprint4.dart';

void main() {
  testWidgets('liga e desliga o agendamento e salva a preferência', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    final lembretes = deps.lembretes as MemoriaLembretesService;
    await abrirTela(tester, deps, const ConfiguracoesPage());

    final controle = find.text('Notificações motivacionais');
    Future<bool> preferencia() async =>
        (await deps.usuarios.observarUsuario().first)!
            .configuracoes
            .notificacoesAtivas;

    await tester.tap(controle);
    await tester.pumpAndSettle();
    expect(lembretes.ativo, isTrue);
    expect(await preferencia(), isTrue);

    await tester.tap(controle);
    await tester.pumpAndSettle();
    expect(lembretes.ativo, isFalse);
    expect(await preferencia(), isFalse);
  });

  testWidgets('permissão negada mantém a preferência desligada', (
    tester,
  ) async {
    final base = Dependencias.memoria();
    final deps = Dependencias(
      auth: base.auth,
      usuarios: base.usuarios,
      diario: base.diario,
      phq9: base.phq9,
      exclusao: base.exclusao,
      lembretes: MemoriaLembretesService(permitido: false),
      usandoFirebase: false,
    );
    await abrirTela(tester, deps, const ConfiguracoesPage());
    await tester.tap(find.text('Notificações motivacionais'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).last).value,
      isFalse,
    );
    expect(
      find.text(
        'Ative as notificações do Respira nas configurações do celular.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('switches refletem e salvam uma cópia das configurações', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    final inicial = Configuracoes(temaEscuro: true);
    await deps.usuarios.salvarConfiguracoes(inicial);
    await tester.pumpWidget(appTeste(deps, const ConfiguracoesPage()));
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile).first).value,
      isTrue,
    );
    await tester.tap(find.text('Tema escuro (leitura noturna)'));
    await tester.pumpAndSettle();
    expect(
      (await deps.usuarios.observarUsuario().first)!.configuracoes.temaEscuro,
      isFalse,
    );
    expect(inicial.temaEscuro, isTrue);
  });

  testWidgets('cartão de pânico abre confirmação em página inteira', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    await tester.pumpWidget(appTeste(deps, const ConfiguracoesPage()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Botão de Pânico'));
    await tester.tap(find.text('Botão de Pânico'));
    await tester.pumpAndSettle();
    expect(find.byType(PanicoPage), findsOneWidget);
  });

  testWidgets('anônimo recebe orientação no lugar de acesso ao perfil', (
    tester,
  ) async {
    await tester.pumpWidget(
      appTeste(Dependencias.memoria(), const ConfiguracoesPage()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Crie uma conta para personalizar'), findsOneWidget);
    expect(
      tester.widget<ListTile>(find.widgetWithText(ListTile, 'Perfil')).onTap,
      isNull,
    );
  });
}
