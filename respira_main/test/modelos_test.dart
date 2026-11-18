import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/crypto/criptografia.dart';
import 'package:respira_main/features/auth/domain/usuario.dart';
import 'package:respira_main/features/configuracoes/domain/configuracoes.dart';
import 'package:respira_main/features/diario/domain/registro_humor.dart';
import 'package:respira_main/features/phq9/domain/resposta_phq9.dart';

void main() {
  setUp(() => Criptografia.instancia.definirChave(Criptografia.gerarChave()));
  tearDown(Criptografia.instancia.limpar);

  group('RegistroHumor', () {
    test('toMap cifra a nota e fromMap devolve o mesmo registro', () {
      final data = DateTime(2026, 11, 18, 22, 40);
      final registro = RegistroHumor(
        humor: NivelHumor.bem,
        nota: 'Dia tranquilo',
        criadoEm: data,
      );

      final mapa = registro.toMap();
      expect(mapa['humor'], 'bem');
      expect(mapa['notaCifrada'], isNot('Dia tranquilo'));
      expect(mapa['criadoEm'], isA<Timestamp>());

      final lido = RegistroHumor.fromMap('abc', mapa);
      expect(lido.id, 'abc');
      expect(lido.humor, NivelHumor.bem);
      expect(lido.nota, 'Dia tranquilo');
      expect(lido.criadoEm, data);
    });

    test('nota vazia vira null e não é cifrada', () {
      final registro = RegistroHumor(humor: NivelHumor.mal, nota: '   ');

      expect(registro.nota, isNull);
      expect(registro.toMap()['notaCifrada'], isNull);
    });

    test('validar recusa nota acima de 10.000 caracteres (RN16)', () {
      expect(
        RegistroHumor(humor: NivelHumor.neutro, nota: 'a' * 10000).validar(),
        isTrue,
      );
      expect(
        RegistroHumor(humor: NivelHumor.neutro, nota: 'a' * 10001).validar(),
        isFalse,
      );
    });
  });

  group('RespostaPHQ9', () {
    RespostaPHQ9 completa(List<int> valores, {DateTime? data}) {
      final resposta = RespostaPHQ9.nova(respondidoEm: data);
      for (var i = 0; i < valores.length; i++) {
        resposta.responder(i, valores[i]);
      }
      return resposta;
    }

    test('só calcula o escore com as nove respostas (RN14)', () {
      final resposta = RespostaPHQ9.nova()..responder(0, 2);

      expect(resposta.estaCompleta(), isFalse);
      expect(resposta.calcularEscore, throwsStateError);
    });

    test('o escore é a soma das respostas, de 0 a 27 (RF07)', () {
      expect(completa(List.filled(9, 0)).calcularEscore(), 0);
      expect(completa(List.filled(9, 3)).calcularEscore(), 27);
      expect(completa([1, 2, 0, 3, 1, 0, 2, 1, 1]).calcularEscore(), 11);
    });

    test('recusa resposta fora da escala de 0 a 3', () {
      expect(() => RespostaPHQ9.nova().responder(0, 4), throwsRangeError);
      expect(() => RespostaPHQ9.nova().responder(9, 1), throwsRangeError);
    });

    test('toMap cifra as respostas e fromMap as recupera', () {
      final data = DateTime(2026, 11, 23, 20, 5);
      final mapa = completa([1, 2, 0, 3, 1, 0, 2, 1, 1], data: data).toMap();

      expect(mapa['escore'], 11);
      expect(mapa['respostasCifradas'], isA<String>());

      final lida = RespostaPHQ9.fromMap('x', mapa);
      expect(lida.respostas, [1, 2, 0, 3, 1, 0, 2, 1, 1]);
      expect(lida.respondidoEm, data);
    });

    test('só pode responder de novo depois de 7 dias (RN17)', () {
      final ultima = DateTime(2026, 11, 17, 10);

      expect(RespostaPHQ9.podeResponder(null), isTrue);
      expect(
        RespostaPHQ9.podeResponder(ultima, agora: DateTime(2026, 11, 24, 9)),
        isFalse,
      );
      expect(
        RespostaPHQ9.podeResponder(ultima, agora: DateTime(2026, 11, 24, 10)),
        isTrue,
      );
      expect(RespostaPHQ9.proximaAplicacao(ultima), DateTime(2026, 11, 24, 10));
    });
  });

  group('Usuario e Configuracoes', () {
    test('o documento novo leva a chave e configurações padrão', () {
      final mapa = Usuario(uid: 'u1', anonimo: true)
          .toMap(chaveCriptografia: 'chave');

      expect(mapa['anonimo'], isTrue);
      expect(mapa['chaveCriptografia'], 'chave');
      expect(mapa['configuracoes'], {
        'temaEscuro': false,
        'notificacoesAtivas': false,
      });
      expect(mapa.containsKey('email'), isFalse);
    });

    test('Configuracoes alterna e redefine', () {
      final config = Configuracoes()
        ..alternarTema()
        ..alternarNotificacoes();
      expect(config.temaEscuro, isTrue);
      expect(config.notificacoesAtivas, isTrue);

      config.redefinir();
      expect(config.toMap(), {'temaEscuro': false, 'notificacoesAtivas': false});
    });
  });
}
