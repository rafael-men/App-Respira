import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/data/colecoes_respira.dart';
import '../../auth/domain/usuario.dart';
import '../domain/configuracoes.dart';

/// Configurações e perfil do usuário (UC10, UC11, UC18), guardados em
/// `usuarios/{uid}`.
abstract class UsuarioRepository {
  Stream<Usuario?> observarUsuario();

  Future<void> salvarConfiguracoes(Configuracoes configuracoes);

  /// Só para usuário cadastrado (RN20). Passe null para remover.
  Future<void> atualizarPerfil({String? nomeUsuario, String? fotoPerfil});
}

class PerfilException implements Exception {
  const PerfilException(this.message);

  final String message;

  @override
  String toString() => message;
}

void _validarPerfil(bool anonimo, String? nomeUsuario, String? fotoPerfil) {
  if (anonimo) {
    throw const PerfilException('Crie uma conta para personalizar o perfil.');
  }
  if (nomeUsuario != null && nomeUsuario.length > Usuario.tamanhoMaximoNome) {
    throw const PerfilException(
      'O nome de usuário pode ter até ${Usuario.tamanhoMaximoNome} caracteres.',
    );
  }
}

class FirestoreUsuarioRepository implements UsuarioRepository {
  FirestoreUsuarioRepository({ColecoesRespira? colecoes, FirebaseAuth? auth})
      : _colecoes = colecoes ?? ColecoesRespira(),
        _auth = auth ?? FirebaseAuth.instance;

  final ColecoesRespira _colecoes;
  final FirebaseAuth _auth;

  @override
  Stream<Usuario?> observarUsuario() async* {
    await _colecoes.aguardarSessao();
    yield* _colecoes.usuarioDoc().snapshots().map((snap) {
      final dados = snap.data();
      if (dados == null) return null;
      return Usuario.fromMap(snap.id, dados, email: _auth.currentUser?.email);
    });
  }

  @override
  Future<void> salvarConfiguracoes(Configuracoes configuracoes) async {
    await _colecoes.aguardarSessao();
    gravarEmSegundoPlano(
      _colecoes.usuarioDoc().update({'configuracoes': configuracoes.toMap()}),
      'salvar configurações',
    );
  }

  @override
  Future<void> atualizarPerfil({String? nomeUsuario, String? fotoPerfil}) async {
    final anonimo = _auth.currentUser?.isAnonymous ?? true;
    _validarPerfil(anonimo, nomeUsuario, fotoPerfil);
    await _colecoes.aguardarSessao();
    gravarEmSegundoPlano(
      _colecoes.usuarioDoc().update({
        'nomeUsuario': nomeUsuario,
        'fotoPerfil': fotoPerfil,
      }),
      'atualizar perfil',
    );
  }
}

/// Versão em memória, para desenvolver e testar as telas sem o Firebase.
class MemoriaUsuarioRepository implements UsuarioRepository {
  MemoriaUsuarioRepository({Usuario? inicial})
      : _usuario = inicial ?? Usuario(uid: 'local', anonimo: true);

  Usuario _usuario;
  final _mudancas = StreamController<Usuario?>.broadcast();

  @override
  Stream<Usuario?> observarUsuario() async* {
    yield _usuario;
    yield* _mudancas.stream;
  }

  /// Usado pelo repositório de autenticação em memória ao cadastrar ou sair.
  void substituir(Usuario usuario) {
    _usuario = usuario;
    _mudancas.add(_usuario);
  }

  @override
  Future<void> salvarConfiguracoes(Configuracoes configuracoes) async {
    substituir(_copiar(configuracoes: configuracoes));
  }

  @override
  Future<void> atualizarPerfil({String? nomeUsuario, String? fotoPerfil}) async {
    _validarPerfil(_usuario.anonimo, nomeUsuario, fotoPerfil);
    substituir(_copiar(
      nomeUsuario: nomeUsuario,
      fotoPerfil: fotoPerfil,
      trocarPerfil: true,
    ));
  }

  Usuario _copiar({
    Configuracoes? configuracoes,
    String? nomeUsuario,
    String? fotoPerfil,
    bool trocarPerfil = false,
  }) =>
      Usuario(
        uid: _usuario.uid,
        anonimo: _usuario.anonimo,
        email: _usuario.email,
        nomeUsuario: trocarPerfil ? nomeUsuario : _usuario.nomeUsuario,
        fotoPerfil: trocarPerfil ? fotoPerfil : _usuario.fotoPerfil,
        configuracoes: configuracoes ?? _usuario.configuracoes,
        criadoEm: _usuario.criadoEm,
      );
}
