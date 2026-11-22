/// Faixas do escore do PHQ-9 (RN22, decisão P3 do grupo em 21/11/2026).
///
/// Os nomes aparecem no selo da Tela 06, sem linguagem alarmista.
enum FaixaPhq9 {
  minima('mínima', 0, 4),
  leve('leve', 5, 9),
  moderada('moderada', 10, 14),
  moderadamenteGrave('moderadamente grave', 15, 19),
  grave('grave', 20, 27);

  const FaixaPhq9(this.rotulo, this.minimo, this.maximo);

  final String rotulo;
  final int minimo;
  final int maximo;

  /// Faixa de um escore de 0 a 27 (RF07).
  static FaixaPhq9 doEscore(int escore) {
    RangeError.checkValueInInterval(escore, 0, 27, 'escore');
    return values.firstWhere((f) => escore >= f.minimo && escore <= f.maximo);
  }
}
