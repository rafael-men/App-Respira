import 'package:flutter/material.dart';

import '../../../core/widgets/respira_app_bar.dart';
import '../../../core/dependencias.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../main/pages/home_page.dart';
import '../data/auth_repository.dart';
import '../domain/auth_validators.dart';
import '../widgets/auth_widgets.dart';
import 'cadastro_page.dart';
import 'recuperar_senha_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _mostrarSenha = false;
  bool _carregando = false;
  String? _erro;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  /// RN24: quem usa o app sem conta e entra numa conta existente perde
  /// os registros feitos neste aparelho, então o app pede confirmação.
  Future<bool> _confirmarTrocaDeConta() async {
    if (!widget.authRepository.anonimo) return true;
    final deps = DependenciasScope.of(context);
    if (!await _temRegistrosSemConta(deps)) return true;
    if (!mounted) return false;

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registros sem conta'),
        content: const Text(
          'Os registros feitos sem conta neste aparelho não serão levados para a conta em que você vai entrar. Para guardá-los, crie uma conta em vez de entrar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Entrar mesmo assim'),
          ),
        ],
      ),
    );
    return confirmou ?? false;
  }

  Future<bool> _temRegistrosSemConta(Dependencias deps) async {
    try {
      final registros = await deps.diario.observarRegistros().first;
      if (registros.isNotEmpty) return true;
      final respostas = await deps.phq9.observarRespostas().first;
      return respostas.isNotEmpty;
    } on Object {
      // Sem como ler os registros, avisa por precaução.
      return true;
    }
  }

  Future<void> _entrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final pode = await _confirmarTrocaDeConta();
    if (!pode || !mounted) return;

    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      await widget.authRepository.entrar(
        email: _emailController.text,
        senha: _senhaController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomePage(authRepository: widget.authRepository),
        ),
        (_) => false,
      );
    } on AuthException catch (e) {
      if (mounted) setState(() => _erro = e.message);
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  void _abrirRecuperarSenha() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RecuperarSenhaPage()));
  }

  void _abrirCadastro() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CadastroPage(authRepository: widget.authRepository),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RespiraAppBar(titulo: 'Entrar na conta'),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeader(
                    titulo: 'Respira',
                    subtitulo: 'Entre para continuar o seu acompanhamento.',
                  ),
                  const SizedBox(height: 32),
                  AuthCard(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                            validator: AuthValidators.email,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _senhaController,
                            obscureText: !_mostrarSenha,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => _entrar(),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _mostrarSenha
                                    ? 'Ocultar senha'
                                    : 'Mostrar senha',
                                icon: Icon(
                                  _mostrarSenha
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                onPressed: () => setState(
                                  () => _mostrarSenha = !_mostrarSenha,
                                ),
                              ),
                            ),
                            validator: AuthValidators.senhaLogin,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _carregando
                                  ? null
                                  : _abrirRecuperarSenha,
                              child: const Text('Esqueci minha senha'),
                            ),
                          ),
                          if (_erro != null) ...[
                            const SizedBox(height: 16),
                            MensagemErro(mensagem: _erro!),
                          ],
                          const SizedBox(height: 24),
                          GradientButton(
                            label: 'Entrar',
                            carregando: _carregando,
                            onPressed: _entrar,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _carregando ? null : _abrirCadastro,
                    child: const Text('Ainda não tem conta? Cadastre-se'),
                  ),
                  const SizedBox(height: 8),
                  const AvisoPrivacidade(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
