import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/auth/data/auth_repository.dart';
import 'package:respira_main/features/auth/widgets/auth_widgets.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:respira_main/features/main/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/configuracoes/data/lembretes_service.dart';
import 'package:respira_main/features/configuracoes/domain/configuracoes.dart';
import 'package:respira_main/features/main/pages/home_page.dart';
import 'package:respira_main/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('AvisoPrivacidade mostra o texto novo', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AvisoPrivacidade())),
    );

    expect(
      find.textContaining(
        'Sem conta, seus dados ficam vinculados a este aparelho.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('não usa internet'), findsNothing);
  });

  testWidgets('o terceiro slide do onboarding mostra "questionário"', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingPage(
          authRepository: LocalAuthRepository(),
          preferencias: PreferenciasUsuario(),
        ),
      ),
    );

    // Avança pelos dois primeiros slides até o terceiro.
    for (var i = 0; i < 2; i++) {
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();
    }

    expect(find.textContaining('questionário'), findsOneWidget);
    expect(find.textContaining('quesrionário'), findsNothing);
  });

  testWidgets('tocar em "Pular" marca o onboarding como concluído', (
    tester,
  ) async {
    final preferencias = PreferenciasUsuario();

    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingPage(
          authRepository: LocalAuthRepository(),
          preferencias: preferencias,
        ),
      ),
    );

    await tester.tap(find.text('Pular'));
    await tester.pumpAndSettle();

    expect(preferencias.onboardingConcluido, isTrue);

    final salvas = await PreferenciasUsuario.carregar();
    expect(salvas.onboardingConcluido, isTrue);
  });

  for (final permitir in [true, false]) {
    testWidgets('onboarding aplica o tema e respeita a permissão: $permitir', (
      tester,
    ) async {
      final lembretes = MemoriaLembretesService(permitido: permitir);
      final deps = await _abrirEscolhas(tester, lembretes);

      await tester.tap(find.text('Escuro'));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.text('Escuro'))).brightness,
        Brightness.dark,
      );

      await _tocar(tester, 'Continuar');
      await _tocar(tester, 'Ativar lembretes');
      expect(lembretes.ativo, isFalse);
      await _tocar(tester, 'Começar');

      expect(lembretes.ativo, permitir);
      final usuario = await deps.usuarios.observarUsuario().first;
      expect(usuario?.configuracoes.notificacoesAtivas, permitir);
      expect(usuario?.configuracoes.temaEscuro, isTrue);
      expect(
        Theme.of(tester.element(find.byType(HomePage))).brightness,
        Brightness.dark,
      );
      if (!permitir) {
        expect(
          find.textContaining('Os lembretes ficaram desativados'),
          findsOneWidget,
        );
      }
    });
  }

  testWidgets('pular o lembrete não confirma a opção selecionada', (
    tester,
  ) async {
    final lembretes = MemoriaLembretesService();
    final deps = await _abrirEscolhas(tester, lembretes);
    await _tocar(tester, 'Claro');
    await _tocar(tester, 'Continuar');
    await _tocar(tester, 'Ativar lembretes');
    await _tocar(tester, 'Pular');

    expect(lembretes.ativo, isFalse);
    final usuario = await deps.usuarios.observarUsuario().first;
    expect(usuario?.configuracoes.notificacoesAtivas, isFalse);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets(
    'Agora não desativa lembrete existente sem perder o tema escolhido',
    (tester) async {
      final lembretes = MemoriaLembretesService();
      await lembretes.ativar();
      final deps = await _abrirEscolhas(tester, lembretes);
      await deps.usuarios.salvarConfiguracoes(
        Configuracoes(notificacoesAtivas: true),
      );

      await _tocar(tester, 'Escuro');
      await _tocar(tester, 'Continuar');
      await _tocar(tester, 'Agora não');
      await _tocar(tester, 'Começar');

      final usuario = await deps.usuarios.observarUsuario().first;
      expect(usuario?.configuracoes.notificacoesAtivas, isFalse);
      expect(usuario?.configuracoes.temaEscuro, isTrue);
      expect(lembretes.ativo, isFalse);
    },
  );
}

Future<Dependencias> _abrirEscolhas(
  WidgetTester tester,
  LembretesService lembretes,
) async {
  final base = Dependencias.memoria();
  final deps = Dependencias(
    auth: base.auth,
    usuarios: base.usuarios,
    diario: base.diario,
    phq9: base.phq9,
    exclusao: base.exclusao,
    lembretes: lembretes,
    usandoFirebase: false,
  );
  await tester.pumpWidget(
    MyApp(
      authRepository: deps.auth,
      dependencias: deps,
      preferencias: PreferenciasUsuario(),
    ),
  );
  await tester.pumpAndSettle();
  for (var i = 0; i < 3; i++) {
    await _tocar(tester, 'Continuar');
  }
  return deps;
}

Future<void> _tocar(WidgetTester tester, String rotulo) async {
  await tester.tap(find.text(rotulo));
  await tester.pumpAndSettle();
}
