import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/crypto/criptografia.dart';
import '../../../core/data/colecoes_respira.dart';
import '../domain/usuario.dart';
import 'auth_repository.dart';

/// Autenticação com Firebase Authentication: uso sem cadastro (provedor
/// anônimo) e cadastro opcional com e-mail e senha (RF17 a RF19).
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? auth, ColecoesRespira? colecoes})
      : _auth = auth ?? FirebaseAuth.instance,
        _colecoes = colecoes ?? ColecoesRespira();

  final FirebaseAuth _auth;
  final ColecoesRespira _colecoes;

  /// Verdadeiro quando a conta existe e a chave de criptografia foi carregada.
  bool _pronta = false;
  Future<void>? _preparando;

  User? get _usuario => _auth.currentUser;

  @override
  String? get emailAtual => _usuario?.email;

  @override
  bool get temSessao => _usuario != null;

  @override
  bool get anonimo => _usuario?.isAnonymous ?? true;

  @override
  Future<void> aguardarSessao() {
    if (_pronta) return Future.value();
    return _preparando ??= _executar(() async {
      final usuario = _usuario ?? (await _auth.signInAnonymously()).user!;
      await _prepararDocumento(usuario);
    }).whenComplete(() => _preparando = null);
  }

  @override
  Future<void> entrarSemCadastro() => aguardarSessao();

  @override
  Future<void> cadastrar({required String email, required String senha}) =>
      _executar(() async {
        final credencial = EmailAuthProvider.credential(
          email: email.trim(),
          password: senha,
        );
        final atual = _usuario;
        final User usuario;
        if (atual != null && atual.isAnonymous) {
          // Mantém o mesmo uid: os dados anônimos continuam na conta (RN19).
          usuario = (await atual.linkWithCredential(credencial)).user!;
        } else {
          usuario = (await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: senha,
          ))
              .user!;
        }
        // Renova o token para as Security Rules verem a sessão cadastrada.
        await usuario.getIdToken(true);
        await _prepararDocumento(usuario);
        await _colecoes.usuarioDoc(usuario.uid).update({'anonimo': false});
      });

  @override
  Future<void> entrar({required String email, required String senha}) =>
      _executar(() async {
        final usuario = (await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: senha,
        ))
            .user!;
        _encerrarSessaoLocal();
        await _prepararDocumento(usuario);
      });

  @override
  Future<void> recuperarSenha({required String email}) => _executar(() async {
        try {
          await _auth.sendPasswordResetEmail(email: email.trim());
        } on FirebaseAuthException catch (e) {
          // Mesma resposta exista ou não a conta (RN21).
          if (e.code != 'user-not-found') rethrow;
        }
      });

  @override
  Future<void> sair() => _executar(() async {
        await _auth.signOut();
        _encerrarSessaoLocal();
        // As telas de dados preparam a sessão anônima quando for necessário.
      });

  @override
  Future<void> excluirConta({String? senha}) => _executar(() async {
        final usuario = _usuario;
        if (usuario == null) return;
        if (!usuario.isAnonymous) await _reautenticar(usuario, senha);
        await usuario.delete();
        await _auth.signOut();
        _encerrarSessaoLocal();
      });

  /// Confirma a senha antes de apagar os dados (Botão de Pânico, RN07).
  /// Precisa de internet.
  Future<void> confirmarSenha(String? senha) => _executar(() async {
        final usuario = _usuario;
        if (usuario == null || usuario.isAnonymous) return;
        await _reautenticar(usuario, senha);
      });

  /// Descarta a chave e marca a sessão como não preparada. Usado ao sair e
  /// pelo Botão de Pânico.
  void encerrarSessaoLocal() => _encerrarSessaoLocal();

  void _encerrarSessaoLocal() {
    _pronta = false;
    Criptografia.instancia.limpar();
  }

  Future<void> _reautenticar(User usuario, String? senha) async {
    if (senha == null || senha.isEmpty) {
      throw const AuthException('Digite sua senha para confirmar.');
    }
    await usuario.reauthenticateWithCredential(
      EmailAuthProvider.credential(email: usuario.email!, password: senha),
    );
  }

  /// Cria `usuarios/{uid}` no primeiro acesso e carrega a chave de
  /// criptografia. Lê primeiro do cache do aparelho, para abrir rápido e
  /// funcionar offline.
  Future<void> _prepararDocumento(User usuario) async {
    final doc = _colecoes.usuarioDoc(usuario.uid);
    DocumentSnapshot<Map<String, dynamic>> snap;
    try {
      snap = await doc.get(const GetOptions(source: Source.cache));
      if (!snap.exists) snap = await doc.get();
    } on FirebaseException {
      snap = await doc.get();
    }
    final dados = snap.data();
    if (dados == null && snap.metadata.isFromCache) {
      // Offline e sem o documento no cache: não dá para saber se ele existe
      // na nuvem. Criar agora sobrescreveria a chave e perderia os dados.
      throw const AuthException(
        'Sem conexão. Tente de novo quando estiver online.',
      );
    }
    var chave = dados?['chaveCriptografia'] as String?;
    if (dados == null) {
      chave = Criptografia.gerarChave();
      await doc.set(
        Usuario(uid: usuario.uid, anonimo: usuario.isAnonymous)
            .toMap(chaveCriptografia: chave),
      );
    }
    if (chave == null) {
      throw const AuthException(
        'Não foi possível carregar seus dados. Tente de novo.',
      );
    }
    Criptografia.instancia.definirChave(chave);
    _pronta = true;
  }

  Future<void> _executar(Future<void> Function() acao) async {
    try {
      await acao();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensagem(e.code));
    } on FirebaseException catch (e) {
      throw AuthException(
        e.code == 'unavailable'
            ? 'Sem conexão. Tente de novo quando estiver online.'
            : 'Algo deu errado. Tente de novo.',
      );
    }
  }

  static String _mensagem(String codigo) => switch (codigo) {
        'email-already-in-use' ||
        'credential-already-in-use' =>
          'Já existe uma conta com este e-mail.',
        'invalid-email' => 'Informe um e-mail válido.',
        'weak-password' => 'A senha deve ter pelo menos 6 caracteres.',
        'wrong-password' ||
        'user-not-found' ||
        'invalid-credential' =>
          'E-mail ou senha incorretos.',
        'too-many-requests' =>
          'Muitas tentativas. Aguarde um pouco e tente de novo.',
        'network-request-failed' =>
          'Sem conexão. Tente de novo quando estiver online.',
        'requires-recent-login' => 'Digite sua senha de novo para confirmar.',
        _ => 'Algo deu errado. Tente de novo.',
      };
}
