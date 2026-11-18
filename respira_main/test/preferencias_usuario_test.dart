import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('sem nada salvo, carrega valores padrão', () async {
    final p = await PreferenciasUsuario.carregar();

    expect(p.objetivo, isNull);
    expect(p.frequencia, isNull);
    expect(p.receberLembretes, isNull);
    expect(p.onboardingConcluido, isFalse);
  });

  test('salvar e carregar mantém as respostas e o onboarding concluído', () async {
    final original = PreferenciasUsuario()
      ..objetivo = ObjetivoUso.ambos
      ..frequencia = FrequenciaRegistro.quandoPrecisar
      ..receberLembretes = false
      ..onboardingConcluido = true;

    await original.salvar();
    final carregada = await PreferenciasUsuario.carregar();

    expect(carregada.objetivo, ObjetivoUso.ambos);
    expect(carregada.frequencia, FrequenciaRegistro.quandoPrecisar);
    expect(carregada.receberLembretes, isFalse);
    expect(carregada.onboardingConcluido, isTrue);
  });

  test('campos nulos são removidos ao salvar de novo', () async {
    final p = PreferenciasUsuario()
      ..objetivo = ObjetivoUso.alivio
      ..receberLembretes = true;
    await p.salvar();

    p
      ..objetivo = null
      ..receberLembretes = null;
    await p.salvar();

    final carregada = await PreferenciasUsuario.carregar();
    expect(carregada.objetivo, isNull);
    expect(carregada.receberLembretes, isNull);
  });
}
