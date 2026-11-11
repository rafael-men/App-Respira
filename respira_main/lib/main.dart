import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/main/data/preferencias_usuario.dart';
import 'features/main/pages/onboarding_page.dart';

void main() {
  runApp(
    MyApp(
      authRepository: LocalAuthRepository(),
      preferencias: PreferenciasUsuario(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.preferencias,
  });

  final AuthRepository authRepository;
  final PreferenciasUsuario preferencias;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Respira',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: OnboardingPage(
        authRepository: authRepository,
        preferencias: preferencias,
      ),
    );
  }
}
