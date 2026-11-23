import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static const _chaveOnboardingConcluido = 'onboardingConcluido';
  static const _respostasAntigas = [
    'objetivo',
    'frequencia',
    'receberLembretes',
  ];

  bool onboardingConcluido = false;

  static Future<PreferenciasUsuario> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferenciasUsuario()
      ..onboardingConcluido = prefs.getBool(_chaveOnboardingConcluido) ?? false;
  }

  Future<void> salvar() async {
    final prefs = await SharedPreferences.getInstance();
    await _removerRespostasAntigas(prefs);
    await prefs.setBool(_chaveOnboardingConcluido, onboardingConcluido);
  }

  /// Apaga os dados locais do onboarding, inclusive os de versões anteriores.
  static Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await _removerRespostasAntigas(prefs);
    await prefs.remove(_chaveOnboardingConcluido);
  }

  static Future<void> _removerRespostasAntigas(SharedPreferences prefs) async {
    for (final chave in _respostasAntigas) {
      await prefs.remove(chave);
    }
  }
}
