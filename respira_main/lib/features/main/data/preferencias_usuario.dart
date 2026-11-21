import 'package:shared_preferences/shared_preferences.dart';

enum ObjetivoUso { alivio, acompanhamento, ambos }

enum FrequenciaRegistro { diaria, semanal, quandoPrecisar }


class PreferenciasUsuario {
  static const _chaveObjetivo = 'objetivo';
  static const _chaveFrequencia = 'frequencia';
  static const _chaveLembretes = 'receberLembretes';
  static const _chaveOnboardingConcluido = 'onboardingConcluido';

  ObjetivoUso? objetivo;
  FrequenciaRegistro? frequencia;
  bool? receberLembretes;
  bool onboardingConcluido = false;

  static Future<PreferenciasUsuario> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final p = PreferenciasUsuario();

    p.objetivo = _enumPorNome(
      ObjetivoUso.values,
      prefs.getString(_chaveObjetivo),
    );
    p.frequencia = _enumPorNome(
      FrequenciaRegistro.values,
      prefs.getString(_chaveFrequencia),
    );
    p.receberLembretes = prefs.getBool(_chaveLembretes);
    p.onboardingConcluido = prefs.getBool(_chaveOnboardingConcluido) ?? false;

    return p;
  }

  Future<void> salvar() async {
    final prefs = await SharedPreferences.getInstance();

    await _gravarOuRemover(prefs, _chaveObjetivo, objetivo?.name);
    await _gravarOuRemover(prefs, _chaveFrequencia, frequencia?.name);

    if (receberLembretes == null) {
      await prefs.remove(_chaveLembretes);
    } else {
      await prefs.setBool(_chaveLembretes, receberLembretes!);
    }

    await prefs.setBool(_chaveOnboardingConcluido, onboardingConcluido);
  }

  /// Apaga do aparelho todas as preferências do onboarding. Usado pelo
  /// Botão de Pânico, que precisa apagar também os dados locais (RN07).
  static Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chaveObjetivo);
    await prefs.remove(_chaveFrequencia);
    await prefs.remove(_chaveLembretes);
    await prefs.remove(_chaveOnboardingConcluido);
  }

  static Future<void> _gravarOuRemover(
    SharedPreferences prefs,
    String chave,
    String? valor,
  ) {
    return valor == null ? prefs.remove(chave) : prefs.setString(chave, valor);
  }

  static T? _enumPorNome<T extends Enum>(List<T> valores, String? nome) {
    for (final valor in valores) {
      if (valor.name == nome) return valor;
    }
    return null;
  }
}
