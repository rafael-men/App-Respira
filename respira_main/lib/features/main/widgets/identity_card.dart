import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

class IdentityCard extends StatelessWidget {
  const IdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 160,
        decoration: const BoxDecoration(gradient: AppColors.brandGradient),
        child: Stack(
          children: [
            Positioned(right: -30, top: -30, child: _Forma(120)),
            Positioned(left: -20, bottom: -40, child: _Forma(140)),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Respire fundo. Este é um espaço seguro, sem julgamentos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Forma extends StatelessWidget {
  const _Forma(this.tamanho);

  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
      ),
    );
  }
}
