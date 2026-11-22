import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/theme/app_theme.dart';

Widget appTeste(Dependencias deps, Widget tela, {bool mostrarVoltar = false}) =>
    DependenciasScope(
      dependencias: deps,
      child: MaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        initialRoute: mostrarVoltar ? '/tela' : '/',
        routes: {
          '/': (_) => mostrarVoltar ? const Scaffold() : tela,
          if (mostrarVoltar) '/tela': (_) => tela,
        },
      ),
    );

Future<void> abrirTela(
  WidgetTester tester,
  Dependencias deps,
  Widget tela,
) async {
  await tester.pumpWidget(
    appTeste(
      deps,
      Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute<void>(builder: (_) => tela)),
            child: const Text('abrir'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('abrir'));
  await tester.pumpAndSettle();
}
