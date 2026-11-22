import 'package:flutter/material.dart';

import '../domain/registro_humor.dart';

/// Mesma ordem, cores e emojis do seletor da Início e do diário.
abstract final class HumorVisual {
  static const emojis = ['😞', '😕', '😐', '🙂', '😄'];
  static const rotulos = ['Muito mal', 'Mal', 'Neutro', 'Bem', 'Muito bem'];
  static const cores = [
    Color(0xFFE1483D),
    Color(0xFFE8844A),
    Color(0xFF8E88AE),
    Color(0xFF9DC2ED),
    Color(0xFF5B4A94),
  ];
  static String emoji(NivelHumor humor) => emojis[humor.index];
  static Color cor(NivelHumor humor) => cores[humor.index];
}
