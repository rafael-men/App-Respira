import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/crypto/criptografia.dart';

/// As cinco opções de humor, de muito mal a muito bem (RF01).
enum NivelHumor { muitoMal, mal, neutro, bem, muitoBem }

/// Um registro do diário de humor (F01). Não pode ser editado depois de
/// salvo (RN03): para corrigir, o usuário exclui e cria outro.
class RegistroHumor {
  RegistroHumor({
    this._id = '',
    required this._humor,
    String? nota,
    DateTime? criadoEm,
  })  : _nota = (nota == null || nota.trim().isEmpty) ? null : nota,
        _criadoEm = criadoEm ?? DateTime.now();

  /// Limite da nota (RF02, RN16). Alto o bastante para não restringir o que
  /// o usuário quer escrever; existe só para proteger o banco.
  static const tamanhoMaximoNota = 10000;

  final String _id;
  final NivelHumor _humor;
  final String? _nota;
  final DateTime _criadoEm;

  /// Vazio até o Firestore gerar o id no `add`.
  String get id => _id;
  NivelHumor get humor => _humor;
  String? get nota => _nota;
  DateTime get criadoEm => _criadoEm;

  /// Confere se a nota respeita o tamanho máximo. O humor é obrigatório pelo
  /// próprio construtor.
  bool validar() => (_nota?.length ?? 0) <= tamanhoMaximoNota;

  Map<String, dynamic> toMap() => {
        'humor': _humor.name,
        'notaCifrada':
            _nota == null ? null : Criptografia.instancia.cifrar(_nota),
        'criadoEm': Timestamp.fromDate(_criadoEm),
      };

  static RegistroHumor fromMap(String id, Map<String, dynamic> dados) {
    final notaCifrada = dados['notaCifrada'] as String?;
    return RegistroHumor(
      id: id,
      humor: NivelHumor.values.byName(dados['humor'] as String),
      nota: notaCifrada == null
          ? null
          : Criptografia.instancia.decifrar(notaCifrada),
      criadoEm: (dados['criadoEm'] as Timestamp).toDate(),
    );
  }

  RegistroHumor copiarComId(String id) =>
      RegistroHumor(id: id, humor: _humor, nota: _nota, criadoEm: _criadoEm);
}
