import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/pages/cadastro_page.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/feature_card.dart';
import '../widgets/identity_card.dart';
import '../widgets/mood_selector.dart';
import '../widgets/sos_cvv_button.dart';
import '../widgets/user_avatar_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _humor;

  void _emBreve() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Disponível em breve.')),
    );
  }

  void _ligarCvv() {
    // A ligação para o 188 ainda não está implementada.
    _emBreve();
  }

  void _abrirConta() {
    final email = widget.authRepository.emailAtual;

    if (email != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conectado como $email.')),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Você ainda não tem conta',
              style: TextStyle(
                color: AppColors.purple900,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Faça login e salve seu progresso com a gente. Sem conta, seus dados ficam só neste aparelho e somem se o app for desinstalado.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              label: 'Entrar',
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        LoginPage(authRepository: widget.authRepository),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        CadastroPage(authRepository: widget.authRepository),
                  ),
                );
              },
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respira'),
        actions: [
          UserAvatarButton(onPressed: _abrirConta),
          SosCvvButton(onPressed: _ligarCvv),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(
            'Como você está se sentindo hoje?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.purple900,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 20),
          MoodSelector(
            selecionado: _humor,
            onSelecionado: (i) => setState(() => _humor = i),
          ),
          const SizedBox(height: 28),
          const Text(
            'O que você quer fazer agora?',
            style: TextStyle(
              color: AppColors.purple900,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.05,
            children: [
              FeatureCard(
                icone: Icons.edit_note_outlined,
                titulo: 'Diário de humor',
                descricao: 'Registre como você está',
                onTap: _emBreve,
              ),
              FeatureCard(
                icone: Icons.air,
                titulo: 'Respiração 4-7-8',
                descricao: 'Alívio em poucos minutos',
                onTap: _emBreve,
              ),
              FeatureCard(
                icone: Icons.assignment_outlined,
                titulo: 'PHQ-9',
                descricao: 'Questionário semanal',
                onTap: _emBreve,
              ),
              FeatureCard(
                icone: Icons.settings_outlined,
                titulo: 'Configurações',
                descricao: 'Tema e lembretes',
                onTap: _emBreve,
              ),
            ],
          ),
          const SizedBox(height: 28),
          const IdentityCard(),
        ],
      ),
    );
  }
}
