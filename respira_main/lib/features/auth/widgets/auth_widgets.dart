import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.titulo, required this.subtitulo});

  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/respira-icon.png',
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppColors.titulo(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitulo,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class MensagemErro extends StatelessWidget {
  const MensagemErro({super.key, required this.mensagem});

  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mensagem,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontFamily: AppTheme.fonteTexto,
          fontSize: 14,
        ),
      ),
    );
  }
}

class AvisoPrivacidade extends StatelessWidget {
  const AvisoPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.lock_outline,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Sem conta, seus dados ficam vinculados a este aparelho. Com conta, você recupera seu histórico se reinstalar o app. Nada é compartilhado.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontFamily: AppTheme.fonteTexto,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
