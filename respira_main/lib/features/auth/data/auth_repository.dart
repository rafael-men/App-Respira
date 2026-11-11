class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class AuthRepository {
  String? get emailAtual;

  Future<void> cadastrar({required String email, required String senha});

  Future<void> entrar({required String email, required String senha});
}

class LocalAuthRepository implements AuthRepository {
  final Map<String, String> _contas = {};
  String? _emailAtual;

  static String _chave(String email) => email.trim().toLowerCase();

  @override
  String? get emailAtual => _emailAtual;

  @override
  Future<void> cadastrar({required String email, required String senha}) async {
    final chave = _chave(email);
    if (_contas.containsKey(chave)) {
      throw const AuthException('Já existe uma conta com este e-mail.');
    }
    _contas[chave] = senha;
    _emailAtual = email.trim();
  }

  @override
  Future<void> entrar({required String email, required String senha}) async {
    final senhaSalva = _contas[_chave(email)];
    if (senhaSalva == null || senhaSalva != senha) {
      throw const AuthException('E-mail ou senha incorretos.');
    }
    _emailAtual = email.trim();
  }
}
