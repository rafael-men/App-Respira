import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../main/pages/home_page.dart';
import '../data/auth_repository.dart';
import '../domain/auth_validators.dart';
import '../widgets/auth_widgets.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarController = TextEditingController();

  bool _mostrarSenha = false;
  bool _carregando = false;
  String? _erro;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      await widget.authRepository.cadastrar(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.purple900,
      ),
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
                    titulo: 'Crie sua conta',
                    subtitulo:
                        'Use um e-mail e uma senha para entrar no Respira.',
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
                            autofillHints: const [AutofillHints.newUsername],
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
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.newPassword],
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              helperText:
                                  'Mínimo de ${AuthValidators.minimoSenha} caracteres',
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
                            validator: AuthValidators.novaSenha,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmarController,
                            obscureText: !_mostrarSenha,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _cadastrar(),
                            decoration: const InputDecoration(
                              labelText: 'Confirmar senha',
                              prefixIcon: Icon(Icons.lock_reset_outlined),
                            ),
                            validator: (valor) => AuthValidators.confirmarSenha(
                              valor,
                              _senhaController.text,
                            ),
                          ),
                          if (_erro != null) ...[
                            const SizedBox(height: 16),
                            MensagemErro(mensagem: _erro!),
                          ],
                          const SizedBox(height: 24),
                          GradientButton(
                            label: 'Criar conta',
                            carregando: _carregando,
                            onPressed: _cadastrar,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
