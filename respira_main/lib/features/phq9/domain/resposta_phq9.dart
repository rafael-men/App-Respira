import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/crypto/criptografia.dart';

/// Uma aplicação semanal do PHQ-9 (F03). Não pode ser editada nem excluída
/// individualmente (RN04).
class RespostaPHQ9 {
  /// Começa uma aplicação nova, com as nove perguntas sem resposta.
  RespostaPHQ9.nova({DateTime? respondidoEm})
      : _id = '',
        _respostas = List<int?>.filled(totalPerguntas, null),
        _respondidoEm = respondidoEm ?? DateTime.now();

  RespostaPHQ9._({
    required this._id,
    required this._respostas,
    required this._respondidoEm,
  });

  static const totalPerguntas = 9;
  static const valorMinimo = 0;
  static const valorMaximo = 3;

  /// Intervalo entre duas aplicações (RN17).
  static const intervalo = Duration(days: 7);

  final String _id;
  final List<int?> _respostas;
  final DateTime _respondidoEm;

  String get id => _id;
  List<int?> get respostas => List.unmodifiable(_respostas);
  DateTime get respondidoEm => _respondidoEm;

  /// Registra a resposta (0 a 3) de uma pergunta (0 a 8).
  void responder(int pergunta, int valor) {
    RangeError.checkValidIndex(pergunta, _respostas, 'pergunta');
    RangeError.checkValueInInterval(valor, valorMinimo, valorMaximo, 'valor');
    _respostas[pergunta] = valor;
  }

  /// O escore só pode ser calculado com as nove respostas (RN14).
  bool estaCompleta() => _respostas.every((r) => r != null);

  /// Soma das nove respostas, de 0 a 27 (RF07).
  int calcularEscore() {
    if (!estaCompleta()) {
      throw StateError('O PHQ-9 ainda tem perguntas sem resposta.');
    }
    return _respostas.fold<int>(0, (soma, r) => soma + r!);
  }

  int get escore => calcularEscore();

  /// Data a partir da qual o usuário pode responder de novo (RN17).
  static DateTime proximaAplicacao(DateTime ultima) => ultima.add(intervalo);

  /// Indica se já passaram 7 dias desde a última aplicação (RN17).
  static bool podeResponder(DateTime? ultima, {DateTime? agora}) {
    if (ultima == null) return true;
    return !(agora ?? DateTime.now()).isBefore(proximaAplicacao(ultima));
  }

  Map<String, dynamic> toMap() => {
        'respostasCifradas':
            Criptografia.instancia.cifrar(jsonEncode(_respostas)),
        'escore': calcularEscore(),
        'respondidoEm': Timestamp.fromDate(_respondidoEm),
      };

  static RespostaPHQ9 fromMap(String id, Map<String, dynamic> dados) {
    final texto = Criptografia.instancia
        .decifrar(dados['respostasCifradas'] as String);
    return RespostaPHQ9._(
      id: id,
      respostas: List<int?>.from(jsonDecode(texto) as List),
      respondidoEm: (dados['respondidoEm'] as Timestamp).toDate(),
    );
  }
}
