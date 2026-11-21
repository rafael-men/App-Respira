import 'package:flutter/material.dart';

import '../features/auth/data/auth_repository.dart';
import '../features/auth/data/firebase_auth_repository.dart';
import '../features/configuracoes/data/lembretes_service.dart';
import '../features/configuracoes/data/usuario_repository.dart';
import '../features/diario/data/diario_repository.dart';
import '../features/panico/data/exclusao_dados_service.dart';
import '../features/phq9/data/phq9_repository.dart';
import 'data/colecoes_respira.dart';

/// Repositórios usados pelas telas. Há duas montagens: com Firebase e em
/// memória (para desenvolver as telas e rodar testes sem o Firebase).
class Dependencias {
  const Dependencias({
    required this.auth,
    required this.usuarios,
    required this.diario,
    required this.phq9,
    required this.exclusao,
    required this.lembretes,
    required this.usandoFirebase,
  });

  factory Dependencias.firebase() {
    final auth = FirebaseAuthRepository();
    // Os repositórios esperam a conta e a chave ficarem prontas.
    final colecoes = ColecoesRespira(aguardarSessao: auth.aguardarSessao);
    return Dependencias(
      auth: auth,
      usuarios: FirestoreUsuarioRepository(colecoes: colecoes),
      diario: FirestoreDiarioRepository(colecoes: colecoes),
      phq9: FirestorePhq9Repository(colecoes: colecoes),
      exclusao: FirestoreExclusaoDadosService(auth: auth, colecoes: colecoes),
      lembretes: LocalLembretesService(),
      usandoFirebase: true,
    );
  }

  factory Dependencias.memoria() {
    final auth = LocalAuthRepository();
    final usuarios = MemoriaUsuarioRepository();
    final diario = MemoriaDiarioRepository();
    final phq9 = MemoriaPhq9Repository();
    return Dependencias(
      auth: auth,
      usuarios: usuarios,
      diario: diario,
      phq9: phq9,
      exclusao: MemoriaExclusaoDadosService(
        auth: auth,
        diario: diario,
        phq9: phq9,
        usuarios: usuarios,
      ),
      lembretes: MemoriaLembretesService(),
      usandoFirebase: false,
    );
  }

  final AuthRepository auth;
  final UsuarioRepository usuarios;
  final DiarioRepository diario;
  final Phq9Repository phq9;
  final ExclusaoDadosService exclusao;

  /// Lembretes motivacionais (F09). Ligado e desligado pela Tela 08.
  final LembretesService lembretes;
  final bool usandoFirebase;
}

/// Disponibiliza as [Dependencias] para qualquer tela:
/// `DependenciasScope.of(context).diario`.
class DependenciasScope extends InheritedWidget {
  const DependenciasScope({
    super.key,
    required this.dependencias,
    required super.child,
  });

  final Dependencias dependencias;

  static Dependencias of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<DependenciasScope>();
    assert(scope != null, 'DependenciasScope não encontrado na árvore.');
    return scope!.dependencias;
  }

  @override
  bool updateShouldNotify(DependenciasScope oldWidget) =>
      dependencias != oldWidget.dependencias;
}
