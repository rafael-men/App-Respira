import 'package:flutter/material.dart';

import '../../features/cvv/pages/confirmacao_cvv_page.dart';
import '../../features/main/widgets/sos_cvv_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Barra superior padrão do Respira (ajuste A5, N01), com o botão SOS do CVV
/// sempre por último, em todas as telas (RF09, RN18). Um toque no SOS abre a
/// confirmação de chamada (Tela 07); a discagem só acontece depois de
/// confirmar (RN09).
///
/// Contrato do grupo (docs/sprints.md, seção 6.4):
/// `RespiraAppBar(titulo: 'PHQ-9')`, com `mostrarVoltar`, `transparente` e
/// `acoesExtras` opcionais.
class RespiraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RespiraAppBar({
    super.key,
    required this.titulo,
    this.mostrarVoltar = true,
    this.transparente = false,
    this.acoesExtras = const [],
  });

  final String titulo;

  /// Mostra a seta "‹", que volta à tela anterior. Use `false` nas telas que
  /// saem por outro caminho, como "Cancelar" (docs/justificativas.md,
  /// seção 4).
  final bool mostrarVoltar;

  /// Fundo transparente com texto e ícones brancos, para telas de fundo em
  /// gradiente (Tela 04).
  final bool transparente;

  /// Ícones mostrados antes do SOS, como o ícone de conta da Início.
  final List<Widget> acoesExtras;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final corTexto = transparente ? Colors.white : AppColors.purple900;
    final podeVoltar = mostrarVoltar && Navigator.of(context).canPop();

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: transparente ? Colors.transparent : null,
      surfaceTintColor: transparente ? Colors.transparent : null,
      foregroundColor: corTexto,
      elevation: 0,
      scrolledUnderElevation: transparente ? 0 : null,
      leading: podeVoltar
          ? IconButton(
              tooltip: 'Voltar',
              icon: const Icon(Icons.chevron_left, size: 32),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      title: Text(
        titulo,
        style: TextStyle(
          color: corTexto,
          fontFamily: AppTheme.fonteTitulos,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        ...acoesExtras,
        SosCvvButton(onPressed: () => ConfirmacaoCvvPage.abrir(context)),
      ],
    );
  }
}
