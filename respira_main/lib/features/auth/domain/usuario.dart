import 'package:cloud_firestore/cloud_firestore.dart';

import '../../configuracoes/domain/configuracoes.dart';

/// Dados do usuário guardados em `usuarios/{uid}`. O e-mail não é gravado no
/// Firestore: vem do Firebase Authentication (minimização de dados).
class Usuario {
  Usuario({
    required this._uid,
    required this._anonimo,
    this._email,
    this._nomeUsuario,
    this._fotoPerfil,
    Configuracoes? configuracoes,
    DateTime? criadoEm,
  })  : _configuracoes = configuracoes ?? Configuracoes(),
        _criadoEm = criadoEm ?? DateTime.now();

  static const tamanhoMaximoNome = 40;

  final String _uid;
  final bool _anonimo;
  final String? _email;
  final String? _nomeUsuario;
  final String? _fotoPerfil;
  final Configuracoes _configuracoes;
  final DateTime _criadoEm;

  String get uid => _uid;
  bool get anonimo => _anonimo;
  String? get email => _email;
  String? get nomeUsuario => _nomeUsuario;

  /// Foto reduzida no aparelho, em Base64 (RF20).
  String? get fotoPerfil => _fotoPerfil;
  Configuracoes get configuracoes => _configuracoes;
  DateTime get criadoEm => _criadoEm;

  /// Documento criado no primeiro acesso. A chave de criptografia é gerada
  /// no aparelho e fica só neste documento (docs/modelagem-firestore.md).
  Map<String, dynamic> toMap({required String chaveCriptografia}) => {
        'anonimo': _anonimo,
        'criadoEm': Timestamp.fromDate(_criadoEm),
        'configuracoes': _configuracoes.toMap(),
        'nomeUsuario': _nomeUsuario,
        'fotoPerfil': _fotoPerfil,
        'chaveCriptografia': chaveCriptografia,
      };

  static Usuario fromMap(
    String uid,
    Map<String, dynamic> dados, {
    String? email,
  }) =>
      Usuario(
        uid: uid,
        anonimo: dados['anonimo'] as bool,
        email: email,
        nomeUsuario: dados['nomeUsuario'] as String?,
        fotoPerfil: dados['fotoPerfil'] as String?,
        configuracoes: Configuracoes.fromMap(
          dados['configuracoes'] as Map<String, dynamic>?,
        ),
        criadoEm: (dados['criadoEm'] as Timestamp).toDate(),
      );
}
