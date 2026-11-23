import 'package:url_launcher/url_launcher.dart';

/// Contato do Centro de Valorização da Vida (F04, RF10). O número é fixo no
/// código (RN08): não vem do Firestore nem da internet, então a ligação
/// funciona mesmo sem conexão.
class ContatoEmergencia {
  const ContatoEmergencia({
    String? numeroDemonstracao =
        const bool.hasEnvironment('RESPIRA_CVV_DEMO_NUMBER')
        ? const String.fromEnvironment('RESPIRA_CVV_DEMO_NUMBER')
        : null,
  }) : _numeroDemonstracao = numeroDemonstracao;

  static const nome = 'CVV';
  static const numero = '188';
  final String? _numeroDemonstracao;

  bool get demonstracao => _numeroDemonstracao != null;

  String? get numeroDiscagem {
    final configurado = _numeroDemonstracao;
    if (configurado == null) return numero;

    final normalizado = configurado.replaceAll(RegExp(r'[\s().-]'), '');
    // Uma configuração inválida impede a discagem na versão de demonstração.
    return RegExp(r'^\+[1-9][0-9]{7,14}$').hasMatch(normalizado)
        ? normalizado
        : null;
  }

  Uri? get destino {
    final discagem = numeroDiscagem;
    return discagem == null ? null : Uri(scheme: 'tel', path: discagem);
  }

  /// Abre o discador do aparelho com o número já digitado. A chamada só começa
  /// quando o usuário toca em ligar no discador. Retorna `false` quando não
  /// há discador (por exemplo, no navegador do computador).
  Future<bool> ligar() async {
    final uri = destino;
    if (uri == null) return false;
    try {
      return await launchUrl(uri);
    } on Exception {
      return false;
    }
  }
}
