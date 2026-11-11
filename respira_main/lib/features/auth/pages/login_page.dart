import 'package:flutter/material.dart';

import '../../../core/widgets/gradient_button.dart';
import '../../main/pages/home_page.dart';
import '../data/auth_repository.dart';
import '../domain/auth_validators.dart';
import '../widgets/auth_widgets.dart';
import 'cadastro_page.dart';

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

  Future<void> _entrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

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
