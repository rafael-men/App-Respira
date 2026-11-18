import 'package:url_launcher/url_launcher.dart';

/// Contato do Centro de Valorização da Vida (F04, RF10). O número é fixo no
/// código (RN08): não vem do Firestore nem da internet, então a ligação
/// funciona mesmo sem conexão.
class ContatoEmergencia {
  const ContatoEmergencia();

  static const nome = 'CVV';
  static const numero = '188';

  /// Abre o discador do aparelho com o 188 já digitado; a chamada só começa
  /// quando o usuário toca em ligar no discador. Retorna `false` quando não
  /// há discador (por exemplo, no navegador do computador).
  Future<bool> ligar() async {
    try {
      return await launchUrl(Uri(scheme: 'tel', path: numero));
    } on Exception {
      return false;
    }
  }
}
