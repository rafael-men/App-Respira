import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class UserAvatarButton extends StatelessWidget {
  const UserAvatarButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Conta',
      onPressed: onPressed,
      icon: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.purple500.withValues(alpha: 0.4)),
        ),
        child: const Icon(
          Icons.person_outline,
          color: AppColors.purple700,
          size: 20,
        ),
      ),
    );
  }
}
