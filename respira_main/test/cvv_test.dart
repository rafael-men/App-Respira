import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/widgets/danger_button.dart';
import 'package:respira_main/features/cvv/domain/contato_emergencia.dart';
import 'package:respira_main/features/cvv/pages/confirmacao_cvv_page.dart';

Widget _app(Widget tela) => DependenciasScope(
      dependencias: Dependencias.memoria(),
      child: MaterialApp(home: tela),
    );

/// Substitui o discador nos testes: conta as chamadas e devolve se "abriu".
class _ContatoFalso extends ContatoEmergencia {
  _ContatoFalso({required this.abre, super.numeroDemonstracao});

  final bool abre;
  int chamadas = 0;

  @override
  Future<bool> ligar() async {
    chamadas++;
    return abre;
  }
}

void main() {
  group('ContatoEmergencia (RN08)', () {
    test('o número do CVV é fixo: 188', () {
      expect(ContatoEmergencia.nome, 'CVV');
      expect(ContatoEmergencia.numero, '188');
      expect(
        const ContatoEmergencia(numeroDemonstracao: null).destino.toString(),
        'tel:188',
      );
    });

    test(
      'normaliza o número de demonstração e bloqueia configuração inválida',
      () {
        const contato = ContatoEmergencia(
          numeroDemonstracao: '+1 (202) 555-0123',
        );
        expect(contato.destino.toString(), 'tel:+12025550123');
        expect(
          const ContatoEmergencia(numeroDemonstracao: '188').destino,
          isNull,
        );
        expect(const ContatoEmergencia(numeroDemonstracao: '').destino, isNull);
      },
    );
  });

  group('Tela 07 Confirmação de chamada ao CVV', () {
    testWidgets('demonstração inválida não oferece discagem', (tester) async {
      await tester.pumpWidget(
        _app(
          const ConfirmacaoCvvPage(
            contato: ContatoEmergencia(numeroDemonstracao: '188'),
          ),
        ),
      );
      expect(find.text('SOS · Demonstração'), findsOneWidget);
      expect(find.text('188'), findsOneWidget);
      expect(
        tester.widget<DangerButton>(find.byType(DangerButton)).onPressed,
        isNull,
      );
    });

    testWidgets('demonstração mantém o 188 no destaque e usa outro destino', (
      tester,
    ) async {
      final contato = _ContatoFalso(
        abre: true,
        numeroDemonstracao: '+12025550123',
      );
      await tester.pumpWidget(_app(ConfirmacaoCvvPage(contato: contato)));
      expect(find.text('SOS · Demonstração'), findsOneWidget);
      expect(find.text('188'), findsOneWidget);
      expect(
        find.textContaining('Destino do teste: +12025550123'),
        findsOneWidget,
      );
      expect(contato.destino.toString(), 'tel:+12025550123');
      expect(contato.chamadas, 0);
      await tester.tap(find.text('Abrir discador de teste'));
      await tester.pumpAndSettle();
      expect(contato.chamadas, 1);
    });

    testWidgets('mostra 188, "Ligar agora" e "Cancelar"', (tester) async {
      await tester.pumpWidget(_app(const ConfirmacaoCvvPage()));

      expect(find.text('Central de Valorização da Vida'), findsOneWidget);
      expect(find.text('188'), findsOneWidget);
      expect(find.text('Você está prestes a ligar para o CVV'), findsOneWidget);
      expect(
        find.text('disponível mesmo sem conexão à internet'),
        findsOneWidget,
      );
      expect(find.text('Ligar agora'), findsOneWidget);
      expect(find.text('Cancelar'), findsOneWidget);
    });

    testWidgets('não tem seta de voltar nem SOS', (tester) async {
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () => ConfirmacaoCvvPage.abrir(context),
              child: const Text('abrir'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsNothing);
      expect(find.byType(CloseButton), findsNothing);
      expect(find.text('SOS'), findsNothing);
    });

    testWidgets('"Cancelar" fecha a tela e volta à tela de origem', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () => ConfirmacaoCvvPage.abrir(context),
              child: const Text('abrir'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      expect(find.byType(ConfirmacaoCvvPage), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmacaoCvvPage), findsNothing);
      expect(find.text('abrir'), findsOneWidget);
    });

    testWidgets('"Ligar agora" chama o discador (RN09)', (tester) async {
      final contato = _ContatoFalso(abre: true);
      await tester.pumpWidget(_app(ConfirmacaoCvvPage(contato: contato)));

      await tester.tap(find.text('Ligar agora'));
      await tester.pumpAndSettle();

      expect(contato.chamadas, 1);
      expect(find.text('Ligue 188 pelo telefone do aparelho.'), findsNothing);
    });

    testWidgets('sem discador, orienta a ligar pelo telefone do aparelho',
        (tester) async {
      final contato = _ContatoFalso(abre: false);
      await tester.pumpWidget(_app(ConfirmacaoCvvPage(contato: contato)));

      await tester.tap(find.text('Ligar agora'));
      await tester.pumpAndSettle();

      expect(find.text('Ligue 188 pelo telefone do aparelho.'), findsOneWidget);
    });
  });
}
