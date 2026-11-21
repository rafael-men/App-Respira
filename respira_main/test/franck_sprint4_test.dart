import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/configuracoes/data/lembretes_service.dart';
import 'package:respira_main/features/main/data/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferenciasUsuario.limpar', () {
    test('apaga todas as preferências do onboarding (RN07)', () async {
      SharedPreferences.setMockInitialValues({});
      final p = PreferenciasUsuario()
        ..objetivo = ObjetivoUso.ambos
        ..frequencia = FrequenciaRegistro.diaria
        ..receberLembretes = true
        ..onboardingConcluido = true;
      await p.salvar();

      await PreferenciasUsuario.limpar();

      final lidas = await PreferenciasUsuario.carregar();
      expect(lidas.objetivo, isNull);
      expect(lidas.frequencia, isNull);
      expect(lidas.receberLembretes, isNull);
      expect(lidas.onboardingConcluido, isFalse);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys(), isEmpty);
    });
  });

  group('MemoriaLembretesService', () {
    test('ativa e desativa', () async {
      final lembretes = MemoriaLembretesService();

      expect(await lembretes.ativar(), isTrue);
      expect(lembretes.ativo, isTrue);

      await lembretes.desativar();
      expect(lembretes.ativo, isFalse);
    });

    test('permissão negada devolve false e não ativa', () async {
      final lembretes = MemoriaLembretesService(permitido: false);

      expect(await lembretes.ativar(), isFalse);
      expect(lembretes.ativo, isFalse);
    });
  });
}
