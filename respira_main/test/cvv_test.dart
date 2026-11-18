import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/cvv/domain/contato_emergencia.dart';
import 'package:respira_main/features/cvv/pages/confirmacao_cvv_page.dart';

Widget _app(Widget tela) => DependenciasScope(
      dependencias: Dependencias.memoria(),
      child: MaterialApp(home: tela),
    );

/// Substitui o discador nos testes: conta as chamadas e devolve se "abriu".
class _ContatoFalso extends ContatoEmergencia {
  _ContatoFalso({required this.abre});

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
    });
  });

  group('Tela 07 Confirmação de chamada ao CVV', () {
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
      await tester.pumpWidget(_app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => ConfirmacaoCvvPage.abrir(context),
            child: const Text('abrir'),
          ),
        ),
      ));
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsNothing);
      expect(find.byType(CloseButton), findsNothing);
      expect(find.text('SOS'), findsNothing);
    });

    testWidgets('"Cancelar" fecha a tela e volta à tela de origem',
        (tester) async {
      await tester.pumpWidget(_app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => ConfirmacaoCvvPage.abrir(context),
            child: const Text('abrir'),
          ),
        ),
      ));
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
