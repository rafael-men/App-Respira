import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/dependencias.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/main/data/preferencias_usuario.dart';
import 'features/main/pages/home_page.dart';
import 'features/main/pages/onboarding_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencias = await _montarDependencias();
  final auth = dependencias.auth;

  // Nos acessos seguintes, abre direto na Início (RN18).
  final sessaoExistente = auth.temSessao;
  final preparo = auth.aguardarSessao();
  // Uma falha depois do limite de espera vira só um aviso no log.
  unawaited(preparo.catchError((Object _) {}));
  if (sessaoExistente) {
    // Carrega a chave antes de abrir a Início. A leitura vem do cache do
    // aparelho; o limite evita prender a abertura se algo demorar.
    try {
      await preparo.timeout(const Duration(seconds: 5));
    } on Object catch (e) {
      debugPrint('Respira: sessão será preparada depois: $e');
    }
  }
  // No primeiro acesso, a conta anônima é criada enquanto o usuário vê o
  // onboarding. Sem internet, ela é criada no próximo uso (RN18).

  runApp(
    MyApp(
      authRepository: auth,
      preferencias: PreferenciasUsuario(),
      dependencias: dependencias,
      sessaoExistente: sessaoExistente,
    ),
  );
}

/// Usa o Firebase quando ele está configurado; senão, os repositórios em
/// memória (lib/firebase_options.dart ainda provisório).
Future<Dependencias> _montarDependencias() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError catch (e) {
    debugPrint('Respira sem Firebase: ${e.message}');
    return Dependencias.memoria();
  }
  // Grava primeiro no aparelho e sincroniza depois (RF16, RNF06).
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  // No navegador, a sessão salva só é restaurada depois do primeiro evento
  // de autenticação; sem esperar, o onboarding apareceria de novo.
  await FirebaseAuth.instance.authStateChanges().first;
  return Dependencias.firebase();
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.preferencias,
    this.dependencias,
    this.sessaoExistente = false,
  });

  final AuthRepository authRepository;
  final PreferenciasUsuario preferencias;
  final Dependencias? dependencias;
  final bool sessaoExistente;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Respira',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: sessaoExistente
          ? HomePage(authRepository: authRepository)
          : OnboardingPage(
              authRepository: authRepository,
              preferencias: preferencias,
            ),
    );
    final deps = dependencias;
    return deps == null
        ? app
        : DependenciasScope(dependencias: deps, child: app);
  }
}
