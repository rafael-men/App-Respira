import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/configuracoes/pages/configuracoes_page.dart';
import 'package:respira_main/features/diario/domain/registro_humor.dart';
import 'package:respira_main/features/diario/pages/historico_humor_page.dart';
import 'package:respira_main/features/diario/pages/registro_humor_page.dart';

import 'suporte_sprint4.dart';

void main() {
  for (final (nome, tela, texto) in const [
    ('registro', RegistroHumorPage(), 'Salvar registro'),
    ('histórico', HistoricoHumorPage(), 'Nota de teste'),
    ('configurações', ConfiguracoesPage(), 'Botão de Pânico'),
  ]) {
    testWidgets('$nome é utilizável em uma tela de 360 px', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 640);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final deps = Dependencias.memoria();
      await deps.diario.registrar(
        RegistroHumor(humor: NivelHumor.bem, nota: 'Nota de teste'),
      );
      await abrirTela(tester, deps, tela);
      await tester.ensureVisible(find.text(texto));
      expect(find.text(texto).hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
