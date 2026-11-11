import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.carregando = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool carregando;

  @override
  Widget build(BuildContext context) {
    final ativo = onPressed != null && !carregando;
    const raio = BorderRadius.all(Radius.circular(16));

    return AnimatedOpacity(
      opacity: ativo ? 1 : 0.6,
      duration: const Duration(milliseconds: 200),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: raio,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: raio,
            onTap: ativo ? onPressed : null,
            child: SizedBox(
              height: 52,
              width: double.infinity,
              child: Center(
                child: carregando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
