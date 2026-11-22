import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Botão de perigo, em gradiente vermelho. Reservado para "Ligar agora"
/// (Tela 07) e "Apagar tudo" (Tela 09), as únicas ações de emergência ou
/// irreversíveis do app (docs/justificativas.md, seção 5).
class DangerButton extends StatelessWidget {
  const DangerButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.carregando = false,
    this.icone,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool carregando;

  /// Ícone opcional antes do texto, como o telefone de "Ligar agora".
  final IconData? icone;

  static const gradiente = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.emergency, AppColors.emergencyDark],
  );

  @override
  Widget build(BuildContext context) {
    final ativo = onPressed != null && !carregando;
    const raio = BorderRadius.all(Radius.circular(16));

    return Semantics(
      button: true,
      enabled: ativo,
      label: label,
      excludeSemantics: true,
      child: Opacity(
        opacity: ativo ? 1 : 0.6,
        child: DecoratedBox(
          decoration: const BoxDecoration(gradient: gradiente, borderRadius: raio),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: raio,
              onTap: ativo ? onPressed : null,
              child: SizedBox(
                height: 56,
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
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (icone != null) ...[
                              Icon(icone, color: Colors.white, size: 22),
                              const SizedBox(width: 10),
                            ],
                            Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
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
