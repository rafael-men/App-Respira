import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/crypto/criptografia.dart';

void main() {
  final cripto = Criptografia.instancia;

  setUp(() => cripto.definirChave(Criptografia.gerarChave()));
  tearDown(cripto.limpar);

  test('cifra e decifra o mesmo texto, com acentos e emojis', () {
    const texto = 'Hoje foi difícil, mas respirei fundo 🙂';
    final cifrado = cripto.cifrar(texto);

    expect(cifrado, isNot(contains('difícil')));
    expect(cripto.decifrar(cifrado), texto);
  });

  test('o mesmo texto gera cifras diferentes a cada vez (nonce aleatório)', () {
    expect(cripto.cifrar('igual'), isNot(cripto.cifrar('igual')));
  });

  test('a chave gerada tem 44 caracteres em Base64 (256 bits)', () {
    expect(Criptografia.gerarChave(), hasLength(44));
  });

  test('outra chave não consegue decifrar', () {
    final cifrado = cripto.cifrar('segredo');
    cripto.definirChave(Criptografia.gerarChave());

    expect(() => cripto.decifrar(cifrado), throwsA(anything));
  });

  test('sem chave carregada, cifrar falha com erro claro', () {
    cripto.limpar();

    expect(() => cripto.cifrar('x'), throwsStateError);
  });

  test('uma nota de 10.000 caracteres cifrada cabe no limite das regras', () {
    final cifrado = cripto.cifrar('ã' * 10000);

    expect(cifrado.length, lessThanOrEqualTo(60000));
  });
}
