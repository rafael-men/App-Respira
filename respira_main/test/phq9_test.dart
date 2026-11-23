import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/widgets/gradient_button.dart';
import 'package:respira_main/features/main/widgets/opcao_resposta.dart';
import 'package:respira_main/features/phq9/domain/faixa_phq9.dart';
import 'package:respira_main/features/phq9/domain/perguntas_phq9.dart';
import 'package:respira_main/features/phq9/domain/resposta_phq9.dart';
import 'package:respira_main/features/phq9/pages/phq9_pergunta_page.dart';
import 'package:respira_main/features/phq9/pages/phq9_resultado_page.dart';

/// Tela de celular (412 x 915) e a Tela 05 aberta por cima de outra tela, para
/// existir a seta de voltar.
Future<void> _abrirPhq9(WidgetTester tester, Dependencias deps) async {
  tester.view.physicalSize = const Size(1236, 2745);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    DependenciasScope(
      dependencias: deps,
      child: MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const Phq9PerguntaPage()),
              ),
              child: const Text('abrir'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('abrir'));
  await tester.pumpAndSettle();
}

Future<void> _tocar(WidgetTester tester, String texto) async {
  await tester.ensureVisible(find.text(texto));
  await tester.tap(find.text(texto));
  await tester.pumpAndSettle();
}

/// Responde as 9 perguntas; [opcaoDaPergunta] devolve o texto da opção.
Future<void> _responderTudo(
  WidgetTester tester,
  String Function(int pergunta) opcaoDaPergunta,
) async {
  for (var i = 0; i < RespostaPHQ9.totalPerguntas; i++) {
    expect(find.text('Pergunta ${i + 1} de 9'), findsOneWidget);
    await _tocar(tester, opcaoDaPergunta(i));
    await _tocar(tester, i == 8 ? 'Ver resultado' : 'Próxima');
  }
}

String _diaMes(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

const _textoApoio = 'Se você estiver pensando em se ferir, você não precisa '
    'passar por isso sozinho(a). O CVV atende 24h, de graça.';

void main() {
  group('Perguntas do PHQ-9', () {
    test('são 9 perguntas e 4 opções de 0 a 3', () {
      expect(PerguntasPhq9.perguntas, hasLength(9));
      expect(PerguntasPhq9.opcoes.map((o) => o.texto), [
        'Nenhuma vez',
        'Alguns dias',
        'Mais da metade dos dias',
        'Quase todos os dias',
      ]);
      expect(PerguntasPhq9.opcoes.map((o) => o.valor), [0, 1, 2, 3]);
      expect(
        PerguntasPhq9.textoCompleto(1),
        'Nas últimas 2 semanas, com que frequência você se sentiu para baixo, '
        'deprimido(a) ou sem perspectiva?',
      );
    });
  });

  group('Faixas do escore (RN22)', () {
    test('cada escore cai na faixa combinada', () {
      const esperado = {
        0: 'mínima',
        4: 'mínima',
        5: 'leve',
        9: 'leve',
        10: 'moderada',
        14: 'moderada',
        15: 'moderadamente grave',
        19: 'moderadamente grave',
        20: 'grave',
        27: 'grave',
      };
      esperado.forEach((escore, rotulo) {
        expect(FaixaPhq9.doEscore(escore).rotulo, rotulo, reason: '$escore');
      });
    });

    test('recusa escore fora de 0 a 27', () {
      expect(() => FaixaPhq9.doEscore(-1), throwsRangeError);
      expect(() => FaixaPhq9.doEscore(28), throwsRangeError);
    });
  });

  group('Tela 05 PHQ-9', () {
    testWidgets('"Próxima" fica desabilitado sem resposta', (tester) async {
      await _abrirPhq9(tester, Dependencias.memoria());

      expect(find.text('Pergunta 1 de 9'), findsOneWidget);
      expect(
        find.text(PerguntasPhq9.textoCompleto(0)),
        findsOneWidget,
      );
      expect(
        tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
        isNull,
      );

      await _tocar(tester, 'Alguns dias');

      expect(
        tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
        isNotNull,
      );
    });

    testWidgets('a seta volta à pergunta anterior e mantém a resposta',
        (tester) async {
      await _abrirPhq9(tester, Dependencias.memoria());
      await _tocar(tester, 'Mais da metade dos dias');
      await _tocar(tester, 'Próxima');
      expect(find.text('Pergunta 2 de 9'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      expect(find.text('Pergunta 1 de 9'), findsOneWidget);
      final opcao = tester.widget<OpcaoResposta>(
        find.widgetWithText(OpcaoResposta, 'Mais da metade dos dias'),
      );
      expect(opcao.selecionada, isTrue);
    });

    testWidgets(
        'responder as 9 perguntas grava, mostra escore, faixa e o cartão de '
        'apoio quando a pergunta 9 é maior que zero (RN22, RN23)',
        (tester) async {
      final deps = Dependencias.memoria();
      await _abrirPhq9(tester, deps);

      await _responderTudo(tester, (_) => 'Alguns dias');

      expect(find.byType(Phq9ResultadoPage), findsOneWidget);
      expect(find.byType(Phq9PerguntaPage), findsNothing);
      expect(tester.widget<Text>(find.byKey(const Key('phq9-escore'))).data, '9');
      expect(tester.widget<Text>(find.byKey(const Key('phq9-faixa'))).data, 'leve');
      expect(find.text(_textoApoio), findsOneWidget);
      expect(find.text('Falar com o CVV'), findsOneWidget);
      expect(
        find.text('Sua evolução aparece a partir da segunda semana.'),
        findsOneWidget,
      );

      final gravadas = await deps.phq9.observarRespostas().first;
      expect(gravadas, hasLength(1));
      expect(gravadas.single.calcularEscore(), 9);
    });

    testWidgets('com a pergunta 9 igual a zero, não há cartão de apoio',
        (tester) async {
      await _abrirPhq9(tester, Dependencias.memoria());

      await _responderTudo(
        tester,
        (i) => i == 8 ? 'Nenhuma vez' : 'Quase todos os dias',
      );

      expect(tester.widget<Text>(find.byKey(const Key('phq9-escore'))).data, '24');
      expect(
        tester.widget<Text>(find.byKey(const Key('phq9-faixa'))).data,
        'grave',
      );
      expect(find.text(_textoApoio), findsNothing);
    });

    testWidgets('antes de 7 dias mostra a data da próxima aplicação (RN17)',
        (tester) async {
      final deps = Dependencias.memoria();
      final ultima = DateTime.now().subtract(const Duration(days: 2));
      final anterior = RespostaPHQ9.nova(respondidoEm: ultima);
      for (var i = 0; i < RespostaPHQ9.totalPerguntas; i++) {
        anterior.responder(i, 0);
      }
      await deps.phq9.registrar(anterior);

      await _abrirPhq9(tester, deps);

      final proxima = ultima.add(const Duration(days: 7));
      expect(
        find.text(
          'Você respondeu o PHQ-9 recentemente. A próxima aplicação fica '
          'disponível em ${_diaMes(proxima)}.',
        ),
        findsOneWidget,
      );
      expect(find.text('Pergunta 1 de 9'), findsNothing);

      await _tocar(tester, 'Ver minha evolução');

      expect(find.byType(Phq9ResultadoPage), findsOneWidget);
      expect(find.text('Evolução do escore'), findsOneWidget);
      expect(find.text('Escore desta semana'), findsNothing);
    });
  });
}
