import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/diario/domain/registro_humor.dart';
import 'package:respira_main/features/panico/pages/panico_page.dart';
import 'package:respira_main/features/phq9/data/phq9_repository.dart';
import 'package:respira_main/features/phq9/domain/resposta_phq9.dart';
import 'package:respira_main/features/respiracao/pages/respiracao_page.dart';

Widget _app(Dependencias deps, Widget tela) => DependenciasScope(
      dependencias: deps,
      child: MaterialApp(home: tela),
    );

void main() {
  group('Tela 04 Respiração', () {
    testWidgets('começa sozinha e segue o padrão 4-7-8 (RF05)', (tester) async {
      await tester.pumpWidget(_app(Dependencias.memoria(), const RespiracaoPage()));

      expect(find.text('Inspire'), findsOneWidget);

      await tester.pump(const Duration(seconds: 5));
      expect(find.text('Segure'), findsOneWidget);

      await tester.pump(const Duration(seconds: 7));
      expect(find.text('Expire'), findsOneWidget);

      await tester.pump(const Duration(seconds: 8));
      expect(find.text('Inspire'), findsOneWidget);
    });

    testWidgets('sem a Tela 07, o SOS avisa que está em breve', (tester) async {
      await tester.pumpWidget(_app(Dependencias.memoria(), const RespiracaoPage()));

      await tester.tap(find.text('SOS'));
      await tester.pump();

      expect(find.text('Disponível em breve.'), findsOneWidget);
    });
  });

  group('Tela 09 Botão de Pânico', () {
    testWidgets('usuário sem cadastro apaga tudo sem senha (RF13)',
        (tester) async {
      final deps = Dependencias.memoria();
      await deps.auth.entrarSemCadastro();
      await deps.diario.registrar(RegistroHumor(humor: NivelHumor.bem));

      await tester.pumpWidget(_app(deps, const PanicoPage()));
      expect(find.text('Sua conta anônima'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.text('Apagar tudo'));
      await tester.pumpAndSettle();

      expect(await deps.diario.observarRegistros().first, isEmpty);
      expect(find.byType(PanicoPage), findsNothing);
    });

    testWidgets('usuário cadastrado precisa da senha certa (RN07)',
        (tester) async {
      final deps = Dependencias.memoria();
      await deps.auth.cadastrar(email: 'lu@example.com', senha: 'segredo1');

      await tester.pumpWidget(_app(deps, const PanicoPage()));
      expect(find.byType(TextField), findsOneWidget);

      await tester.tap(find.text('Apagar tudo'));
      await tester.pump();
      expect(find.text('Digite sua senha para confirmar.'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'errada');
      await tester.tap(find.text('Apagar tudo'));
      await tester.pump();
      expect(find.text('Senha incorreta.'), findsOneWidget);
      expect(deps.auth.anonimo, isFalse);
    });

    testWidgets('Cancelar fecha a tela sem apagar nada', (tester) async {
      final deps = Dependencias.memoria();
      await deps.diario.registrar(RegistroHumor(humor: NivelHumor.mal));

      await tester.pumpWidget(_app(
        deps,
        Builder(
          builder: (context) => TextButton(
            onPressed: () => PanicoPage.abrir(context),
            child: const Text('abrir'),
          ),
        ),
      ));
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(find.byType(PanicoPage), findsNothing);
      expect(await deps.diario.observarRegistros().first, hasLength(1));
    });
  });

  group('Repositório do PHQ-9 em memória', () {
    test('recusa nova aplicação antes de 7 dias (RN17)', () async {
      final repo = MemoriaPhq9Repository();
      RespostaPHQ9 completa(DateTime data) {
        final r = RespostaPHQ9.nova(respondidoEm: data);
        for (var i = 0; i < RespostaPHQ9.totalPerguntas; i++) {
          r.responder(i, 1);
        }
        return r;
      }

      await repo.registrar(completa(DateTime(2026, 11, 17)));
      expect(
        () => repo.registrar(completa(DateTime(2026, 11, 20))),
        throwsA(isA<Phq9ForaDoIntervaloException>()),
      );
      await repo.registrar(completa(DateTime(2026, 11, 24)));
      expect(await repo.observarRespostas().first, hasLength(2));
    });
  });
}
