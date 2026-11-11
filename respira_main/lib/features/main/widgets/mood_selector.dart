import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.selecionado,
    required this.onSelecionado,
  });

  final int? selecionado;
  final ValueChanged<int> onSelecionado;

  static const _humores = [
    _Humor('😞', 'Muito mal', Color(0xFFE1483D)),
    _Humor('😕', 'Mal', Color(0xFFE8844A)),
    _Humor('😐', 'Neutro', Color(0xFF8E88AE)),
    _Humor('🙂', 'Bem', Color(0xFF9DC2ED)),
    _Humor('😄', 'Muito bem', Color(0xFF5B4A94)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_humores.length, (i) {
        final humor = _humores[i];
        final ativo = selecionado == i;

        return Semantics(
          button: true,
          selected: ativo,
          label: humor.rotulo,
          excludeSemantics: true,
          child: AnimatedScale(
            scale: ativo ? 1.1 : 1,
            duration: const Duration(milliseconds: 200),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ativo ? humor.cor : Colors.white,
                border: Border.all(color: humor.cor, width: 1.5),
                boxShadow: ativo
                    ? [
                        BoxShadow(
                          color: humor.cor.withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => onSelecionado(i),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Center(
                      child: Text(
                        humor.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Humor {
  const _Humor(this.emoji, this.rotulo, this.cor);

  final String emoji;
  final String rotulo;
  final Color cor;
}
