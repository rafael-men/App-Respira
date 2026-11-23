import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/core/theme/app_theme.dart';
import 'package:respira_main/features/configuracoes/pages/configuracoes_page.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:respira_main/features/main/pages/home_page.dart';
import 'package:respira_main/main.dart';

void main() {
  testWidgets('o tema aplica Inter ao corpo e Poppins aos títulos', (
    tester,
  ) async {
    late ThemeData tema;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) {
            tema = Theme.of(context);
            return Scaffold(appBar: AppBar(title: const Text('Tipografia')));
          },
        ),
      ),
    );
    expect(tema.textTheme.bodyMedium?.fontFamily, 'Inter');
    expect(tema.textTheme.titleLarge?.fontFamily, 'Poppins');
    final titulo = DefaultTextStyle.of(tester.element(find.text('Tipografia')));
    expect(titulo.style.fontFamily, 'Poppins');
    expect(titulo.style.color, tema.colorScheme.onSurface);
    expect(AppTheme.fontFamily, AppTheme.fonteTexto);
  });

  testWidgets('tema escuro muda a tela e é restaurado ao reabrir o app', (
    tester,
  ) async {
    final deps = Dependencias.memoria();
    Widget app() => MyApp(
      authRepository: deps.auth,
      dependencias: deps,
      preferencias: PreferenciasUsuario(),
      sessaoExistente: true,
    );
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    final inicio = tester.element(find.byType(HomePage));
    expect(Theme.of(inicio).brightness, Brightness.light);
    Navigator.of(
      inicio,
    ).push(MaterialPageRoute<void>(builder: (_) => const ConfiguracoesPage()));
    await tester.pumpAndSettle();

    final interruptor = find.widgetWithText(
      SwitchListTile,
      'Tema escuro (leitura noturna)',
    );
    await tester.tap(interruptor);
    await tester.pumpAndSettle();

    final tema = Theme.of(tester.element(interruptor));
    expect(tema.brightness, Brightness.dark);
    expect(tema.scaffoldBackgroundColor, const Color(0xFF191627));
    expect(tema.colorScheme.surface, const Color(0xFF241F38));
    expect(tema.textTheme.bodyMedium?.fontFamily, 'Inter');
    expect(tester.widget<SwitchListTile>(interruptor).value, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(HomePage))).brightness,
      Brightness.dark,
    );
  });
}
