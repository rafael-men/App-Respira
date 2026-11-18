import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/data/colecoes_respira.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/firebase_auth_repository.dart';
import '../../auth/domain/usuario.dart';
import '../../configuracoes/data/usuario_repository.dart';
import '../../diario/data/diario_repository.dart';
import '../../phq9/data/phq9_repository.dart';

/// Exclusão total pelo Botão de Pânico (UC12, RF13), na ordem de
/// docs/modelagem-firestore.md, seção 8.
abstract class ExclusaoDadosService {
  /// Apaga tudo. Retorna `true` quando a exclusão chegou à nuvem e a conta
  /// foi excluída, e `false` quando os dados sumiram do aparelho mas a
  /// exclusão na nuvem ficou na fila, por falta de conexão (RN15).
  Future<bool> apagarTudo({String? senha});
}

class FirestoreExclusaoDadosService implements ExclusaoDadosService {
  FirestoreExclusaoDadosService({
    required this._auth,
    ColecoesRespira? colecoes,
    this._esperaNuvem = const Duration(seconds: 10),
  }) : _colecoes = colecoes ?? ColecoesRespira();

  final FirebaseAuthRepository _auth;
  final ColecoesRespira _colecoes;

  /// Quanto tempo esperar a nuvem confirmar a exclusão antes de considerar
  /// que o aparelho está offline.
  final Duration _esperaNuvem;

  /// Máximo de operações por lote no Firestore.
  static const _tamanhoLote = 500;

  @override
  Future<bool> apagarTudo({String? senha}) async {
    // 0. Usuário cadastrado confirma a senha antes de qualquer exclusão, para
    //    uma senha errada não apagar os dados e manter a conta (RN07). Essa
    //    confirmação precisa de internet.
    await _auth.confirmarSenha(senha);
    await _colecoes.aguardarSessao();

    final uid = _colecoes.uid;
    final usuarioDoc = _colecoes.usuarioDoc(uid);
    final referencias = <DocumentReference>[
      ...(await usuarioDoc.collection('registros_humor').get()).docs
          .map((d) => d.reference),
      ...(await usuarioDoc.collection('respostas_phq9').get()).docs
          .map((d) => d.reference),
      usuarioDoc,
    ];

    // 1 a 3. Os lotes são aplicados primeiro no cache do aparelho: os dados
    //        somem da tela na hora, sem esperar a nuvem (RN07).
    final envios = <Future<void>>[];
    for (var i = 0; i < referencias.length; i += _tamanhoLote) {
      final lote = _colecoes.db.batch();
      for (final ref in referencias.skip(i).take(_tamanhoLote)) {
        lote.delete(ref);
      }
      envios.add(lote.commit());
    }

    // A conta só é excluída depois que a nuvem confirma a exclusão dos
    // dados: excluir antes deixaria a fila sem permissão e os dados órfãos.
    try {
      await Future.wait(envios).timeout(_esperaNuvem);
    } on TimeoutException {
      // Offline: os dados já sumiram do aparelho e a exclusão fica na fila
      // do Firestore. A conta é mantida, vazia, para a fila ainda ter
      // permissão de apagar os dados quando a conexão voltar (RN15).
      for (final envio in envios) {
        gravarEmSegundoPlano(envio, 'apagar dados na nuvem');
      }
      _auth.encerrarSessaoLocal();
      return false;
    }

    // 4. Exclui a conta no Firebase Authentication.
    await _auth.excluirConta(senha: senha);
    return true;
  }
}

/// Versão em memória, para desenvolver e testar sem o Firebase.
class MemoriaExclusaoDadosService implements ExclusaoDadosService {
  MemoriaExclusaoDadosService({
    required this.auth,
    required this.diario,
    required this.phq9,
    required this.usuarios,
  });

  final AuthRepository auth;
  final MemoriaDiarioRepository diario;
  final MemoriaPhq9Repository phq9;
  final MemoriaUsuarioRepository usuarios;

  @override
  Future<bool> apagarTudo({String? senha}) async {
    if (!auth.anonimo && (senha == null || senha.isEmpty)) {
      throw const AuthException('Digite sua senha para confirmar.');
    }
    await auth.excluirConta(senha: senha);
    diario.limpar();
    phq9.limpar();
    // Usuário vazio, como no primeiro acesso.
    usuarios.substituir(Usuario(uid: 'local', anonimo: true));
    return true;
  }
}
