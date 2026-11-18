import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/data/colecoes_respira.dart';
import '../domain/resposta_phq9.dart';

/// Acesso às aplicações do PHQ-9 (UC06, UC07, UC08). Não há edição nem
/// exclusão individual (RN04).
abstract class Phq9Repository {
  /// Respostas da mais antiga para a mais recente, para o gráfico (Tela 06).
  Stream<List<RespostaPHQ9>> observarRespostas();

  /// Data da aplicação mais recente, ou null se nunca respondeu (RN17).
  Future<DateTime?> ultimaAplicacao();

  /// Grava uma aplicação completa. Recusa se ainda não passaram 7 dias.
  Future<void> registrar(RespostaPHQ9 resposta);
}

class Phq9ForaDoIntervaloException implements Exception {
  const Phq9ForaDoIntervaloException(this.proximaAplicacao);

  final DateTime proximaAplicacao;
}

class FirestorePhq9Repository implements Phq9Repository {
  FirestorePhq9Repository({ColecoesRespira? colecoes})
      : _colecoes = colecoes ?? ColecoesRespira();

  final ColecoesRespira _colecoes;

  @override
  Stream<List<RespostaPHQ9>> observarRespostas() async* {
    await _colecoes.aguardarSessao();
    yield* _colecoes
        .respostasPhq9()
        .orderBy('respondidoEm')
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  @override
  Future<DateTime?> ultimaAplicacao() async {
    await _colecoes.aguardarSessao();
    // O campo respondidoEm é lido sem decifrar as respostas.
    final consulta = await _colecoes
        .usuarioDoc()
        .collection('respostas_phq9')
        .orderBy('respondidoEm', descending: true)
        .limit(1)
        .get();
    if (consulta.docs.isEmpty) return null;
    return (consulta.docs.first.data()['respondidoEm'] as Timestamp).toDate();
  }

  @override
  Future<void> registrar(RespostaPHQ9 resposta) async {
    final ultima = await ultimaAplicacao();
    if (!RespostaPHQ9.podeResponder(ultima, agora: resposta.respondidoEm)) {
      throw Phq9ForaDoIntervaloException(
        RespostaPHQ9.proximaAplicacao(ultima!),
      );
    }
    gravarEmSegundoPlano(
      _colecoes.respostasPhq9().add(resposta),
      'gravar resposta do PHQ-9',
    );
  }
}

/// Versão em memória, para desenvolver e testar as telas sem o Firebase.
class MemoriaPhq9Repository implements Phq9Repository {
  final _respostas = <RespostaPHQ9>[];
  final _mudancas = StreamController<List<RespostaPHQ9>>.broadcast();

  List<RespostaPHQ9> get _ordenadas =>
      [..._respostas]..sort((a, b) => a.respondidoEm.compareTo(b.respondidoEm));

  @override
  Stream<List<RespostaPHQ9>> observarRespostas() async* {
    yield _ordenadas;
    yield* _mudancas.stream;
  }

  @override
  Future<DateTime?> ultimaAplicacao() async =>
      _respostas.isEmpty ? null : _ordenadas.last.respondidoEm;

  @override
  Future<void> registrar(RespostaPHQ9 resposta) async {
    final ultima = await ultimaAplicacao();
    if (!RespostaPHQ9.podeResponder(ultima, agora: resposta.respondidoEm)) {
      throw Phq9ForaDoIntervaloException(
        RespostaPHQ9.proximaAplicacao(ultima!),
      );
    }
    resposta.calcularEscore(); // garante que está completa (RN14)
    _respostas.add(resposta);
    _mudancas.add(_ordenadas);
  }

  void limpar() {
    _respostas.clear();
    _mudancas.add(const []);
  }
}
