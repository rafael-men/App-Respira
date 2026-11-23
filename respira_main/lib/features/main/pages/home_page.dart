import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/respira_app_bar.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/pages/cadastro_page.dart';
import '../../auth/pages/login_page.dart';
import '../../configuracoes/pages/configuracoes_page.dart';
import '../../diario/domain/registro_humor.dart';
import '../../diario/pages/registro_humor_page.dart';
import '../../configuracoes/pages/perfil_page.dart';
import '../../cvv/pages/confirmacao_cvv_page.dart';
import '../../phq9/pages/phq9_pergunta_page.dart';
import '../../respiracao/pages/respiracao_page.dart';
import '../widgets/feature_card.dart';
import '../widgets/identity_card.dart';
import '../widgets/mood_selector.dart';
import '../widgets/user_avatar_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _humor;
  bool _saindo = false;

  void _ligarCvv() {
    // Abre a confirmação (Tela 07); a discagem só acontece depois de
    // "Ligar agora" (RN09).
    ConfirmacaoCvvPage.abrir(context);
  }

  void _abrirConta() {
    if (_saindo) return;

    final auth = widget.authRepository;
    final email = auth.emailAtual?.trim();

    if (!auth.anonimo && email != null && email.isNotEmpty) {
      _mostrarFolhaDaConta(email);
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Você ainda não tem conta',
              style: TextStyle(
                color: AppColors.titulo(context),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sem cadastro, seus registros ficam no Firebase, vinculados à '
              'sessão anônima deste aparelho. Crie uma conta para manter o '
              'acesso a eles ao trocar de aparelho ou reinstalar o app.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  Future<void> _mostrarFolhaDaConta(String email) async {
    final sair = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Conectado como $email',
              style: TextStyle(
                color: AppColors.titulo(context),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                PerfilPage.abrir(context);
              },
              child: const Text('Editar perfil'),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Sair da conta'),
            ),
          ],
        ),
      ),
    );
    if (sair != true || !mounted) return;
    _saindo = true;

    try {
      await widget.authRepository.sair();
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      _saindo = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RespiraAppBar(
        titulo: 'Respira',
        mostrarVoltar: false,
        acoesExtras: [UserAvatarButton(onPressed: _abrirConta)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(
            'Como você está se sentindo hoje?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.titulo(context),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          MoodSelector(
            selecionado: _humor,
            onSelecionado: (i) {
              setState(() => _humor = i);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      RegistroHumorPage(humorInicial: NivelHumor.values[i]),
                ),
              );
            },
          ),
          const SizedBox(height: 28),
          Text(
            'O que você quer fazer agora?',
            style: TextStyle(
              color: AppColors.titulo(context),
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
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegistroHumorPage()),
                ),
              ),
              FeatureCard(
                icone: Icons.air,
                titulo: 'Respiração 4-7-8',
                descricao: 'Alívio em poucos minutos',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RespiracaoPage(onSos: _ligarCvv),
                  ),
                ),
              ),
              FeatureCard(
                icone: Icons.assignment_outlined,
                titulo: 'PHQ-9',
                descricao: 'Questionário semanal',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Phq9PerguntaPage()),
                ),
              ),
              FeatureCard(
                icone: Icons.settings_outlined,
                titulo: 'Configurações',
                descricao: 'Tema e lembretes',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ConfiguracoesPage()),
                ),
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
