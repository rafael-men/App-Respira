import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('sem nada salvo, o onboarding ainda não foi concluído', () async {
    expect((await PreferenciasUsuario.carregar()).onboardingConcluido, isFalse);
  });

  test('preserva a conclusão salva por uma versão anterior', () async {
    SharedPreferences.setMockInitialValues({
      'onboardingConcluido': true,
      'frequencia': 'diaria',
    });
    expect((await PreferenciasUsuario.carregar()).onboardingConcluido, isTrue);
  });

  test('salva a conclusão e remove as respostas antigas', () async {
    SharedPreferences.setMockInitialValues({
      'objetivo': 'ambos',
      'frequencia': 'semanal',
      'receberLembretes': true,
    });
    await (PreferenciasUsuario()..onboardingConcluido = true).salvar();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), {'onboardingConcluido'});
    expect((await PreferenciasUsuario.carregar()).onboardingConcluido, isTrue);
  });
}
