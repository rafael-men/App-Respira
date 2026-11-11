import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OpcaoResposta extends StatelessWidget {
  const OpcaoResposta({
    super.key,
    required this.texto,
    required this.selecionada,
    required this.onTap,
  });

  final String texto;
  final bool selecionada;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const raio = BorderRadius.all(Radius.circular(14));
    final duracao = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 220);

    return Semantics(
      button: true,
      selected: selecionada,
      child: AnimatedContainer(
        duration: duracao,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selecionada
              ? AppColors.purple500.withValues(alpha: 0.12)
              : Colors.white,
          borderRadius: raio,
          border: Border.all(
            color: selecionada
                ? AppColors.purple700
                : AppColors.purple500.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: raio,
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 56),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: duracao,
                        curve: Curves.easeOut,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          height: 1.4,
                          fontWeight: selecionada
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                        child: Text(texto),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedSwitcher(
                      duration: duracao,
                      transitionBuilder: (child, animacao) =>
                          ScaleTransition(scale: animacao, child: child),
                      child: Icon(
                        selecionada
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        key: ValueKey<bool>(selecionada),
                        color: AppColors.purple700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
