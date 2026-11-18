import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/dart.dart';

/// Cifra e decifra no aparelho a nota do diário e as respostas do PHQ-9
/// (RF12, RN06), com AES-GCM de 256 bits.
///
/// A chave é gerada no primeiro acesso e guardada no documento do usuário no
/// Firestore (campo `chaveCriptografia`), protegida pelas Security Rules.
/// Assim, quem se cadastra recupera os dados ao reinstalar o app (RN19).
class Criptografia {
  Criptografia._();

  /// Instância única usada pelos modelos em `toMap()` e `fromMap()`.
  static final Criptografia instancia = Criptografia._();

  static final _algoritmo = DartAesGcm.with256bits();

  SecretKeyData? _chave;

  /// Indica se a chave do usuário atual já foi carregada.
  bool get pronta => _chave != null;

  /// Gera uma nova chave de 256 bits, em Base64, para um usuário novo.
  static String gerarChave() {
    final aleatorio = Random.secure();
    final bytes = List<int>.generate(32, (_) => aleatorio.nextInt(256));
    return base64Encode(bytes);
  }

  /// Carrega a chave do usuário atual (lida do documento `usuarios/{uid}`).
  void definirChave(String chaveBase64) {
    _chave = SecretKeyData(base64Decode(chaveBase64));
  }

  /// Descarta a chave ao sair da conta ou no Botão de Pânico.
  void limpar() => _chave = null;

  String cifrar(String texto) {
    final caixa = _algoritmo.encryptSync(
      utf8.encode(texto),
      secretKeyData: _chaveObrigatoria(),
    );
    return base64Encode(caixa.concatenation());
  }

  String decifrar(String textoCifrado) {
    final caixa = SecretBox.fromConcatenation(
      base64Decode(textoCifrado),
      nonceLength: _algoritmo.nonceLength,
      macLength: _algoritmo.macAlgorithm.macLength,
    );
    final bytes = _algoritmo.decryptSync(
      caixa,
      secretKeyData: _chaveObrigatoria(),
    );
    return utf8.decode(bytes);
  }

  SecretKeyData _chaveObrigatoria() {
    final chave = _chave;
    if (chave == null) {
      throw StateError('A chave de criptografia ainda não foi carregada.');
    }
    return chave;
  }
}
