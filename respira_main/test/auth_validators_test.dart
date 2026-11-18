import 'package:flutter_test/flutter_test.dart';
import 'package:respira_main/features/auth/domain/auth_validators.dart';

void main() {
  group('email', () {
    test('aceita e-mails válidos', () {
      expect(AuthValidators.email('pessoa@exemplo.com'), isNull);
      expect(AuthValidators.email('  pessoa@exemplo.com.br  '), isNull);
    });

    test('recusa vazio e formatos inválidos', () {
      expect(AuthValidators.email(null), isNotNull);
      expect(AuthValidators.email('   '), isNotNull);
      expect(AuthValidators.email('sem-arroba.com'), isNotNull);
      expect(AuthValidators.email('pessoa@sem-dominio'), isNotNull);
      expect(AuthValidators.email('pes soa@exemplo.com'), isNotNull);
    });
  });

  group('senhaLogin', () {
    test('só exige que a senha tenha sido preenchida', () {
      expect(AuthValidators.senhaLogin('1'), isNull);
      expect(AuthValidators.senhaLogin(null), isNotNull);
      expect(AuthValidators.senhaLogin(''), isNotNull);
    });
  });

  group('novaSenha', () {
    test('exige no mínimo 6 caracteres', () {
      expect(AuthValidators.novaSenha('123456'), isNull);
      expect(AuthValidators.novaSenha('12345'), isNotNull);
      expect(AuthValidators.novaSenha(''), isNotNull);
      expect(AuthValidators.novaSenha(null), isNotNull);
    });
  });

  group('confirmarSenha', () {
    test('aceita quando as senhas são iguais', () {
      expect(AuthValidators.confirmarSenha('abcdef', 'abcdef'), isNull);
    });

    test('recusa vazio e senhas diferentes', () {
      expect(AuthValidators.confirmarSenha(null, 'abcdef'), isNotNull);
      expect(AuthValidators.confirmarSenha('', 'abcdef'), isNotNull);
      expect(AuthValidators.confirmarSenha('abcdeX', 'abcdef'), isNotNull);
    });
  });
}
