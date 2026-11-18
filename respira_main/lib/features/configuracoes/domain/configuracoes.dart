/// Preferências de tema e de notificações (RF14, RF15). Gravadas como mapa
/// dentro do documento `usuarios/{uid}`.
class Configuracoes {
  Configuracoes({this._temaEscuro = false, this._notificacoesAtivas = false});

  bool _temaEscuro;
  bool _notificacoesAtivas;

  bool get temaEscuro => _temaEscuro;
  bool get notificacoesAtivas => _notificacoesAtivas;

  void alternarTema() => _temaEscuro = !_temaEscuro;

  void alternarNotificacoes() => _notificacoesAtivas = !_notificacoesAtivas;

  /// Volta ao padrão, no lugar de uma exclusão (CRUD em docs/requisitos.md).
  void redefinir() {
    _temaEscuro = false;
    _notificacoesAtivas = false;
  }

  Map<String, dynamic> toMap() => {
        'temaEscuro': _temaEscuro,
        'notificacoesAtivas': _notificacoesAtivas,
      };

  static Configuracoes fromMap(Map<String, dynamic>? dados) => Configuracoes(
        temaEscuro: dados?['temaEscuro'] as bool? ?? false,
        notificacoesAtivas: dados?['notificacoesAtivas'] as bool? ?? false,
      );
}
