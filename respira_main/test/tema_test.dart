import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/theme/app_theme.dart';

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
}
