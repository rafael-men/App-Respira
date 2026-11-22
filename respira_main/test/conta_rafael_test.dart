import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/core/dependencias.dart';
import 'package:respira_main/features/auth/data/auth_repository.dart';
import 'package:respira_main/features/auth/pages/login_page.dart';
import 'package:respira_main/features/auth/pages/recuperar_senha_page.dart';
import 'package:respira_main/features/configuracoes/data/usuario_repository.dart';
import 'package:respira_main/features/configuracoes/pages/perfil_page.dart';
import 'package:respira_main/features/auth/domain/usuario.dart';
import 'package:respira_main/features/diario/domain/registro_humor.dart';
import 'package:respira_main/features/main/pages/home_page.dart';

/// Montagem em memória com um repositório de autenticação escolhido pelo teste.
Dependencias _montar({
  required AuthRepository auth,
  UsuarioRepository? usuarios,
}) {
  final base = Dependencias.memoria();
  return Dependencias(
    auth: auth,
    usuarios: usuarios ?? base.usuarios,
    diario: base.diario,
    phq9: base.phq9,
    exclusao: base.exclusao,
    lembretes: base.lembretes,
    usandoFirebase: false,
  );
}

Widget _com(Dependencias deps, Widget tela) {
  return DependenciasScope(
    dependencias: deps,
    child: MaterialApp(home: tela),
  );
}

void main() {
  group('recuperação de senha (N08)', () {
    testWidgets('e-mail inválido mostra erro e não envia', (tester) async {
      final auth = LocalAuthRepository();
      await tester.pumpWidget(
        _com(_montar(auth: auth), const RecuperarSenhaPage()),
      );

      await tester.enterText(find.byType(TextFormField), 'abc');
      await tester.tap(find.text('Enviar link'));
      await tester.pumpAndSettle();

      expect(find.text('Informe um e-mail válido.'), findsOneWidget);
      expect(find.textContaining('Se houver uma conta'), findsNothing);
    });

    testWidgets('envio mostra a mensagem genérica (RN21)', (tester) async {
      final auth = LocalAuthRepository();
      await tester.pumpWidget(
        _com(_montar(auth: auth), const RecuperarSenhaPage()),
      );

      await tester.enterText(find.byType(TextFormField), 'ana@teste.com');
      await tester.tap(find.text('Enviar link'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Se houver uma conta com esse e-mail, você vai receber o link em alguns minutos.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('"Esqueci minha senha" no login abre a tela', (tester) async {
      final auth = LocalAuthRepository();
      await tester.pumpWidget(
        _com(_montar(auth: auth), LoginPage(authRepository: auth)),
      );

      await tester.tap(find.text('Esqueci minha senha'));
      await tester.pumpAndSettle();

      expect(find.text('Esqueceu a senha?'), findsOneWidget);
    });
  });

  group('sair da conta (N09)', () {
    testWidgets(
      'com conta, a folha mostra "Sair da conta" e sair deixa o uso sem cadastro',
      (tester) async {
        final auth = LocalAuthRepository();
        await auth.cadastrar(email: 'ana@teste.com', senha: '123456');
        await tester.pumpWidget(
          _com(_montar(auth: auth), HomePage(authRepository: auth)),
        );

        await tester.tap(find.byTooltip('Conta'));
        await tester.pumpAndSettle();

        expect(find.text('Conectado como ana@teste.com'), findsOneWidget);
        expect(find.text('Sair da conta'), findsOneWidget);

        await tester.tap(find.text('Sair da conta'));
        await tester.pumpAndSettle();

        expect(auth.anonimo, isTrue);
        expect(find.text('Sair da conta'), findsNothing);
        expect(find.byType(HomePage), findsOneWidget);
      },
    );

    testWidgets('"Editar perfil" abre o perfil', (tester) async {
      final auth = LocalAuthRepository();
      await auth.cadastrar(email: 'ana@teste.com', senha: '123456');
      await tester.pumpWidget(
        _com(
          _montar(
            auth: auth,
            usuarios: MemoriaUsuarioRepository(
              inicial: Usuario(uid: 'u1', anonimo: false),
            ),
          ),
          HomePage(authRepository: auth),
        ),
      );

      await tester.tap(find.byTooltip('Conta'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Editar perfil'));
      await tester.pumpAndSettle();

      expect(find.text('Nome de usuário (opcional)'), findsOneWidget);
    });
  });

  group('perfil (N10)', () {
    testWidgets('salva o nome no repositório em memória', (tester) async {
      final auth = LocalAuthRepository();
      await auth.cadastrar(email: 'ana@teste.com', senha: '123456');
      final usuarios = MemoriaUsuarioRepository(
        inicial: Usuario(uid: 'u1', anonimo: false),
      );
      await tester.pumpWidget(
        _com(
          _montar(auth: auth, usuarios: usuarios),
          Scaffold(
            body: Builder(
              builder: (ctx) => TextButton(
                onPressed: () => PerfilPage.abrir(ctx),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Nome de usuário (opcional)'),
        '  Ana  ',
      );
      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();

      final usuario = await usuarios.observarUsuario().first;
      expect(usuario?.nomeUsuario, 'Ana');
    });

    testWidgets('nome com mais de 40 caracteres mostra erro', (tester) async {
      final auth = LocalAuthRepository();
      await auth.cadastrar(email: 'ana@teste.com', senha: '123456');
      final usuarios = MemoriaUsuarioRepository(
        inicial: Usuario(uid: 'u1', anonimo: false),
      );
      await tester.pumpWidget(
        _com(_montar(auth: auth, usuarios: usuarios), const PerfilPage()),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextField, 'Nome de usuário (opcional)'),
        'a' * 41,
      );
      await tester.tap(find.text('Salvar'));
      await tester.pumpAndSettle();

      expect(
        find.text('O nome de usuário pode ter até 40 caracteres.'),
        findsOneWidget,
      );
      final usuario = await usuarios.observarUsuario().first;
      expect(usuario?.nomeUsuario, isNull);
    });

    testWidgets('sem cadastro mostra o convite e não o formulário', (
      tester,
    ) async {
      final auth = LocalAuthRepository();
      await tester.pumpWidget(_com(_montar(auth: auth), const PerfilPage()));
      await tester.pumpAndSettle();

      expect(
        find.text('Crie uma conta para personalizar seu perfil.'),
        findsOneWidget,
      );
      expect(find.text('Criar conta'), findsOneWidget);
      expect(find.text('Nome de usuário (opcional)'), findsNothing);
    });
  });

  group('aviso antes de trocar de conta (RN24)', () {
    Future<LocalAuthRepository> contaExistenteSemLogin() async {
      final auth = LocalAuthRepository();
      await auth.cadastrar(email: 'ana@teste.com', senha: '123456');
      await auth.sair();
      return auth;
    }

    Future<void> preencherELogar(WidgetTester tester) async {
      await tester.enterText(find.byType(TextFormField).at(0), 'ana@teste.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();
    }

    testWidgets(
      'aparece quando há registros sem conta; Cancelar não troca de conta',
      (tester) async {
        final auth = await contaExistenteSemLogin();
        final deps = _montar(auth: auth);
        await deps.diario.registrar(RegistroHumor(humor: NivelHumor.bem));
        await tester.pumpWidget(_com(deps, LoginPage(authRepository: auth)));

        await preencherELogar(tester);

        expect(find.text('Registros sem conta'), findsOneWidget);

        await tester.tap(find.text('Cancelar'));
        await tester.pumpAndSettle();

        expect(auth.emailAtual, isNull);
        expect(find.byType(LoginPage), findsOneWidget);
      },
    );

    testWidgets('"Entrar mesmo assim" segue para a conta', (tester) async {
      final auth = await contaExistenteSemLogin();
      final deps = _montar(auth: auth);
      await deps.diario.registrar(RegistroHumor(humor: NivelHumor.mal));
      await tester.pumpWidget(_com(deps, LoginPage(authRepository: auth)));

      await preencherELogar(tester);
      await tester.tap(find.text('Entrar mesmo assim'));
      await tester.pumpAndSettle();

      expect(auth.emailAtual, 'ana@teste.com');
    });

    testWidgets('não aparece quando não há registros', (tester) async {
      final auth = await contaExistenteSemLogin();
      await tester.pumpWidget(
        _com(_montar(auth: auth), LoginPage(authRepository: auth)),
      );

      await preencherELogar(tester);

      expect(find.text('Registros sem conta'), findsNothing);
      expect(auth.emailAtual, 'ana@teste.com');
    });
  });
}
