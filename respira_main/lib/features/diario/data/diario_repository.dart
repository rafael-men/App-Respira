import 'dart:async';

import '../../../core/data/colecoes_respira.dart';
import '../domain/registro_humor.dart';

/// Acesso aos registros do diário de humor (UC02, UC03, UC04).
abstract class DiarioRepository {
  /// Registros do mais recente para o mais antigo (Tela 03). Funciona offline.
  Stream<List<RegistroHumor>> observarRegistros();

  Future<void> registrar(RegistroHumor registro);

  Future<void> excluir(String id);
}

/// Grava no Cloud Firestore. Com a persistência offline, a gravação vai
/// primeiro para o cache do aparelho (RF16, RN05).
class FirestoreDiarioRepository implements DiarioRepository {
  FirestoreDiarioRepository({ColecoesRespira? colecoes})
      : _colecoes = colecoes ?? ColecoesRespira();

  final ColecoesRespira _colecoes;

  @override
  Stream<List<RegistroHumor>> observarRegistros() async* {
    await _colecoes.aguardarSessao();
    yield* _colecoes
        .registrosHumor()
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  @override
  Future<void> registrar(RegistroHumor registro) async {
    if (!registro.validar()) {
      throw ArgumentError('A nota passa do tamanho máximo.');
    }
    await _colecoes.aguardarSessao();
    gravarEmSegundoPlano(
      _colecoes.registrosHumor().add(registro),
      'gravar registro de humor',
    );
  }

  @override
  Future<void> excluir(String id) async {
    await _colecoes.aguardarSessao();
    gravarEmSegundoPlano(
      _colecoes.registrosHumor().doc(id).delete(),
      'excluir registro de humor',
    );
  }
}

/// Versão em memória, para desenvolver e testar as telas sem o Firebase.
class MemoriaDiarioRepository implements DiarioRepository {
  final _registros = <RegistroHumor>[];
  final _mudancas = StreamController<List<RegistroHumor>>.broadcast();
  var _proximoId = 1;

  List<RegistroHumor> get _ordenados =>
      [..._registros]..sort((a, b) => b.criadoEm.compareTo(a.criadoEm));

  @override
  Stream<List<RegistroHumor>> observarRegistros() async* {
    yield _ordenados;
    yield* _mudancas.stream;
  }

  @override
  Future<void> registrar(RegistroHumor registro) async {
    if (!registro.validar()) {
      throw ArgumentError('A nota passa do tamanho máximo.');
    }
    _registros.add(registro.copiarComId('${_proximoId++}'));
    _mudancas.add(_ordenados);
  }

  @override
  Future<void> excluir(String id) async {
    _registros.removeWhere((r) => r.id == id);
    _mudancas.add(_ordenados);
  }

  void limpar() {
    _registros.clear();
    _mudancas.add(const []);
  }
}
