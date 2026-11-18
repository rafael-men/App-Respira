import 'package:flutter/material.dart';

/// Aviso usado pelos botões cujas telas ainda não foram implementadas, como
/// o SOS antes da Tela 07. Mesmo texto da Início.
void avisarEmBreve(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Disponível em breve.')),
  );
}
