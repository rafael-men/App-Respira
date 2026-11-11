abstract final class AuthValidators {
  static final _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  static const minimoSenha = 6;

  static String? email(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe seu e-mail.';
    if (!_emailRegex.hasMatch(texto)) return 'Informe um e-mail válido.';
    return null;
  }

  static String? senhaLogin(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe sua senha.';
    return null;
  }

  static String? novaSenha(String? valor) {
    if (valor == null || valor.isEmpty) return 'Crie uma senha.';
    if (valor.length < minimoSenha) {
      return 'A senha deve ter pelo menos $minimoSenha caracteres.';
    }
    return null;
  }

  static String? confirmarSenha(String? valor, String senha) {
    if (valor == null || valor.isEmpty) return 'Confirme sua senha.';
    if (valor != senha) return 'As senhas não coincidem.';
    return null;
  }
}
