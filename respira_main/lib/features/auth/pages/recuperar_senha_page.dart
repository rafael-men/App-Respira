import 'package:flutter/material.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../data/auth_repository.dart';
import '../domain/auth_validators.dart';
import '../widgets/auth_widgets.dart';

/// Envia o link de redefinição de senha (RN21).
class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({super.key});

  @override
  State<RecuperarSenhaPage> createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  /// Mesma mensagem para qualquer e-mail, existindo ou não conta (RN21).
  static const _mensagemEnviado =
      'Se houver uma conta com esse e-mail, você vai receber o link em alguns minutos.';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _carregando = false;
  bool _enviado = false;
  String? _erro;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final auth = DependenciasScope.of(context).auth;
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      await auth.recuperarSenha(email: _emailController.text);
      if (mounted) setState(() => _enviado = true);
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
        title: const Text('Recuperar senha'),
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
                    titulo: 'Esqueceu a senha?',
                    subtitulo:
                        'Informe o e-mail da sua conta e enviaremos um link para você criar uma nova senha.',
                  ),
                  const SizedBox(height: 32),
                  AuthCard(
                    child: _enviado ? _confirmacao() : _formulario(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            onFieldSubmitted: (_) => _enviar(),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.mail_outline),
            ),
            validator: AuthValidators.email,
          ),
          if (_erro != null) ...[
            const SizedBox(height: 16),
            MensagemErro(mensagem: _erro!),
          ],
          const SizedBox(height: 24),
          GradientButton(
            label: 'Enviar link',
            carregando: _carregando,
            onPressed: _enviar,
          ),
        ],
      ),
    );
  }

  Widget _confirmacao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          _mensagemEnviado,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 24),
        GradientButton(
          label: 'Voltar ao login',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
