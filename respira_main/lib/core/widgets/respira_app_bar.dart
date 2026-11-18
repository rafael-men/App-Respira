import 'package:flutter/material.dart';

import '../../features/cvv/pages/confirmacao_cvv_page.dart';
import '../../features/main/widgets/sos_cvv_button.dart';
import '../theme/app_colors.dart';

/// AppBar padrão do Respira (ajuste A5), com o botão SOS do CVV à direita em
/// todas as telas (RF09, RN18). Um toque no SOS abre a confirmação de chamada
/// (Tela 07); a discagem só acontece depois de confirmar (RN09).
///
/// Uso: `RespiraAppBar(titulo: 'PHQ-9')`.
class RespiraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RespiraAppBar({
    super.key,
    required this.titulo,
    this.mostrarVoltar = true,
    this.transparente = false,
    this.acoes = const [],
    this.onSos,
    this.mostrarSos = true,
  });

  final String titulo;

  /// Mostra a seta "‹", que volta à tela anterior. Use `false` nas telas de
  /// confirmação, que saem pelo botão "Cancelar" (docs/justificativas.md,
  /// seção 4).
  final bool mostrarVoltar;

  /// Fundo transparente com texto e ícones brancos, para telas de fundo em
  /// gradiente (Tela 04).
  final bool transparente;

  /// Ícones extras, mostrados antes do SOS (por exemplo, o ícone de conta da
  /// Início).
  final List<Widget> acoes;

  /// Troca a ação do SOS. Sem ela, o SOS abre a Tela 07.
  final VoidCallback? onSos;

  /// Só a própria Tela 07 esconde o SOS, para não abrir a si mesma.
  final bool mostrarSos;

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
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        ...acoes,
        if (mostrarSos)
          SosCvvButton(
            onPressed: onSos ?? () => ConfirmacaoCvvPage.abrir(context),
          ),
      ],
    );
  }
}
