import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/auth/data/auth_repository.dart';
import 'package:respira_main/features/auth/widgets/auth_widgets.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:respira_main/features/main/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('AvisoPrivacidade mostra o texto novo', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AvisoPrivacidade())),
    );

    expect(
      find.textContaining('Sem conta, seus dados ficam vinculados a este aparelho.'),
      findsOneWidget,
    );
    expect(find.textContaining('não usa internet'), findsNothing);
  });

  testWidgets('o terceiro slide do onboarding mostra "questionário"', (tester) async {
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

  testWidgets('tocar em "Pular" marca o onboarding como concluído', (tester) async {
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
}
