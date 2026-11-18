class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class AuthRepository {
  String? get emailAtual;

  /// Indica se já existe uma sessão (anônima ou cadastrada) neste aparelho.
  /// Usado para pular o onboarding nos acessos seguintes (RN18).
  bool get temSessao;

  /// Indica se a sessão atual é de uso sem cadastro (RF17).
  bool get anonimo;

  /// Entra sem cadastro, de forma anônima, se ainda não houver sessão (RF17).
  Future<void> entrarSemCadastro();

  /// Garante que a conta existe e que a chave de criptografia foi carregada.
  /// Os repositórios chamam antes de ler ou gravar. Sem internet no primeiro
  /// acesso, lança [AuthException].
  Future<void> aguardarSessao();

  /// Cria a conta. Se o usuário já usava o app sem cadastro, os dados são
  /// mantidos (RN19).
  Future<void> cadastrar({required String email, required String senha});

  Future<void> entrar({required String email, required String senha});

  /// Envia o link de redefinição. Não revela se o e-mail tem conta (RN21).
  Future<void> recuperarSenha({required String email});

  /// Sai da conta e volta ao uso sem cadastro.
  Future<void> sair();

  /// Exclui a conta (Botão de Pânico). Para usuário cadastrado, a senha é
  /// pedida de novo como confirmação (RN07).
  Future<void> excluirConta({String? senha});
}

/// Implementação em memória, usada em testes e quando o Firebase ainda não
/// está configurado. Nada é salvo depois que o app fecha.
class LocalAuthRepository implements AuthRepository {
  final Map<String, String> _contas = {};
  String? _emailAtual;
  bool _temSessao = false;

  static String _chave(String email) => email.trim().toLowerCase();

  @override
  String? get emailAtual => _emailAtual;

  @override
  bool get temSessao => _temSessao;

  @override
  bool get anonimo => _emailAtual == null;

  @override
  Future<void> entrarSemCadastro() async => _temSessao = true;

  @override
  Future<void> aguardarSessao() => entrarSemCadastro();

  @override
  Future<void> cadastrar({required String email, required String senha}) async {
    final chave = _chave(email);
    if (_contas.containsKey(chave)) {
      throw const AuthException('Já existe uma conta com este e-mail.');
    }
    _contas[chave] = senha;
    _emailAtual = email.trim();
    _temSessao = true;
  }

  @override
  Future<void> entrar({required String email, required String senha}) async {
    final senhaSalva = _contas[_chave(email)];
    if (senhaSalva == null || senhaSalva != senha) {
      throw const AuthException('E-mail ou senha incorretos.');
    }
    _emailAtual = email.trim();
    _temSessao = true;
  }

  @override
  Future<void> recuperarSenha({required String email}) async {}

  @override
  Future<void> sair() async => _emailAtual = null;

  @override
  Future<void> excluirConta({String? senha}) async {
    final email = _emailAtual;
    if (email != null) {
      if (_contas[_chave(email)] != senha) {
        throw const AuthException('Senha incorreta.');
      }
      _contas.remove(_chave(email));
    }
    _emailAtual = null;
    _temSessao = false;
  }
}
