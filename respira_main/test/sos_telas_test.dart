import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/widgets/respira_app_bar.dart';
import 'package:respira_main/features/auth/pages/cadastro_page.dart';
import 'package:respira_main/features/auth/pages/login_page.dart';
import 'package:respira_main/features/auth/pages/recuperar_senha_page.dart';
import 'package:respira_main/features/configuracoes/pages/configuracoes_page.dart';
import 'package:respira_main/features/configuracoes/pages/perfil_page.dart';
import 'package:respira_main/features/cvv/pages/confirmacao_cvv_page.dart';
import 'package:respira_main/features/diario/pages/historico_humor_page.dart';
import 'package:respira_main/features/diario/pages/registro_humor_page.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:respira_main/features/main/pages/home_page.dart';
import 'package:respira_main/features/main/pages/onboarding_page.dart';
import 'package:respira_main/features/panico/pages/panico_page.dart';
import 'package:respira_main/features/phq9/pages/phq9_pergunta_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app(Dependencias deps, Widget tela) => DependenciasScope(
      dependencias: deps,
      child: MaterialApp(home: tela),
    );

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  final telas = <Widget Function(Dependencias)>[
    (_) => const RegistroHumorPage(),
    (_) => const HistoricoHumorPage(),
    (_) => const ConfiguracoesPage(),
    (_) => const PerfilPage(),
    (deps) => OnboardingPage(
      authRepository: deps.auth,
      preferencias: PreferenciasUsuario(),
    ),
    (deps) => LoginPage(authRepository: deps.auth),
    (deps) => CadastroPage(authRepository: deps.auth),
    (_) => const RecuperarSenhaPage(),
  ];

  for (final montar in telas) {
    final deps = Dependencias.memoria();
    final tela = montar(deps);
    testWidgets('SOS abre confirmação e volta em ${tela.runtimeType}', (
      tester,
    ) async {
      await tester.pumpWidget(_app(deps, tela));
      await tester.pumpAndSettle();
      expect(find.byType(RespiraAppBar), findsOneWidget);
      await tester.tap(find.text('SOS'));
      await tester.pumpAndSettle();
      expect(find.byType(ConfirmacaoCvvPage), findsOneWidget);
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.byType(tela.runtimeType), findsOneWidget);
    });
  }

  group('SOS ligado à Tela 07 (N03, RF09, RN18)', () {
    testWidgets('na Início, a barra é a RespiraAppBar e o SOS abre a Tela 07',
        (tester) async {
      final deps = Dependencias.memoria();
      await tester.pumpWidget(_app(deps, HomePage(authRepository: deps.auth)));

      expect(find.byType(RespiraAppBar), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsNothing);

      await tester.tap(
        find.descendant(
          of: find.byType(RespiraAppBar),
          matching: find.text('SOS'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmacaoCvvPage), findsOneWidget);
      expect(find.text('Disponível em breve.'), findsNothing);
    });

    testWidgets('na Tela 09, o SOS abre a Tela 07 e não há seta',
        (tester) async {
      await tester.pumpWidget(_app(Dependencias.memoria(), const PanicoPage()));

      expect(find.byIcon(Icons.chevron_left), findsNothing);

      await tester.tap(find.text('SOS'));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmacaoCvvPage), findsOneWidget);
    });
  });

  testWidgets('na Início, o card PHQ-9 abre a Tela 05 (N07)', (tester) async {
    // Largura padrão dos testes (800) e altura suficiente para os quatro
    // cards da Início caberem sem rolar.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final deps = Dependencias.memoria();
    await tester.pumpWidget(_app(deps, HomePage(authRepository: deps.auth)));

    await tester.tap(find.text('Questionário semanal'));
    await tester.pumpAndSettle();

    expect(find.byType(Phq9PerguntaPage), findsOneWidget);
    expect(find.text('Pergunta 1 de 9'), findsOneWidget);
  });
}
