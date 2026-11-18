import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../features/diario/domain/registro_humor.dart';
import '../../features/phq9/domain/resposta_phq9.dart';

/// Referências às coleções do usuário logado, já convertidas para as classes
/// Dart (docs/mapeamento-dart-firestore.md, seção 5).
class ColecoesRespira {
  ColecoesRespira({
    FirebaseFirestore? db,
    FirebaseAuth? auth,
    this._aguardarSessao,
  })  : _db = db ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final Future<void> Function()? _aguardarSessao;

  FirebaseFirestore get db => _db;

  /// Espera a conta e a chave de criptografia ficarem prontas antes de ler
  /// ou gravar (veja AuthRepository.aguardarSessao).
  Future<void> aguardarSessao() => _aguardarSessao?.call() ?? Future.value();

  String get uid {
    final usuario = _auth.currentUser;
    if (usuario == null) {
      throw StateError('Nenhum usuário autenticado.');
    }
    return usuario.uid;
  }

  DocumentReference<Map<String, dynamic>> usuarioDoc([String? uid]) =>
      _db.collection('usuarios').doc(uid ?? this.uid);

  CollectionReference<RegistroHumor> registrosHumor([String? uid]) =>
      usuarioDoc(uid).collection('registros_humor').withConverter<RegistroHumor>(
            fromFirestore: (snap, _) =>
                RegistroHumor.fromMap(snap.id, snap.data()!),
            toFirestore: (registro, _) => registro.toMap(),
          );

  CollectionReference<RespostaPHQ9> respostasPhq9([String? uid]) =>
      usuarioDoc(uid).collection('respostas_phq9').withConverter<RespostaPHQ9>(
            fromFirestore: (snap, _) =>
                RespostaPHQ9.fromMap(snap.id, snap.data()!),
            toFirestore: (resposta, _) => resposta.toMap(),
          );
}

/// Envia uma gravação ao Firestore sem esperar o servidor. A gravação já
/// está no cache do aparelho; offline, o Future só terminaria quando a
/// conexão voltasse (RF16). Erros, como uma recusa das Security Rules, vão
/// para o log em vez de se perderem.
void gravarEmSegundoPlano(Future<void> gravacao, String descricao) {
  unawaited(
    gravacao.catchError((Object erro) {
      debugPrint('Respira: falha ao $descricao: $erro');
    }),
  );
}
