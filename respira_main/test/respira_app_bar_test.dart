import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/widgets/respira_app_bar.dart';
import 'package:respira_main/features/cvv/pages/confirmacao_cvv_page.dart';

Widget _app(Widget tela) => DependenciasScope(
      dependencias: Dependencias.memoria(),
      child: MaterialApp(home: tela),
    );

/// Tela inicial com um botão que abre uma segunda tela com a AppBar, para
/// existir uma tela anterior para onde voltar.
Widget _comTelaAnterior(RespiraAppBar appBar) => _app(
      Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Scaffold(appBar: appBar),
              ),
            ),
            child: const Text('abrir'),
          ),
        ),
      ),
    );

void main() {
  group('RespiraAppBar (ajuste A5)', () {
    testWidgets('mostra o título e o SOS (RF09)', (tester) async {
      await tester.pumpWidget(
        _app(const Scaffold(appBar: RespiraAppBar(titulo: 'PHQ-9'))),
      );

      expect(find.text('PHQ-9'), findsOneWidget);
      expect(find.text('SOS'), findsOneWidget);
    });

    testWidgets('tocar no SOS abre a ConfirmacaoCvvPage (RN09)',
        (tester) async {
      await tester.pumpWidget(
        _app(const Scaffold(appBar: RespiraAppBar(titulo: 'PHQ-9'))),
      );

      await tester.tap(find.text('SOS'));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmacaoCvvPage), findsOneWidget);
    });

    testWidgets('a seta volta à tela anterior', (tester) async {
      await tester.pumpWidget(
        _comTelaAnterior(const RespiraAppBar(titulo: 'PHQ-9')),
      );
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      expect(find.text('PHQ-9'), findsNothing);
      expect(find.text('abrir'), findsOneWidget);
    });

    testWidgets('com mostrarVoltar: false não há seta', (tester) async {
      await tester.pumpWidget(
        _comTelaAnterior(
          const RespiraAppBar(titulo: 'Botão de Pânico', mostrarVoltar: false),
        ),
      );
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      expect(find.text('Botão de Pânico'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_left), findsNothing);
      expect(find.byType(BackButton), findsNothing);
    });

    testWidgets('transparente deixa o fundo transparente e o texto branco',
        (tester) async {
      await tester.pumpWidget(
        _app(
          const Scaffold(
            appBar: RespiraAppBar(titulo: 'Respiração', transparente: true),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.transparent);
      expect(appBar.foregroundColor, Colors.white);
    });

    testWidgets('acoes aparecem antes do SOS', (tester) async {
      await tester.pumpWidget(
        _app(
          const Scaffold(
            appBar: RespiraAppBar(
              titulo: 'Respira',
              acoes: [Icon(Icons.person_outline)],
            ),
          ),
        ),
      );

      final conta = tester.getCenter(find.byIcon(Icons.person_outline));
      final sos = tester.getCenter(find.text('SOS'));
      expect(conta.dx, lessThan(sos.dx));
    });
  });
}
