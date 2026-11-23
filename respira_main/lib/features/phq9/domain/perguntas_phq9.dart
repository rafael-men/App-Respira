/// Perguntas e opções do PHQ-9 na versão em português (F03, RF06).
///
/// Cada tela da Tela 05 mostra o [enunciado] seguido de uma das [perguntas];
/// o valor de cada opção entra no escore (RF07).
abstract final class PerguntasPhq9 {
  static const enunciado = 'Nas últimas 2 semanas, com que frequência você';

  static const perguntas = <String>[
    'teve pouco interesse ou pouco prazer em fazer as coisas?',
    'se sentiu para baixo, deprimido(a) ou sem perspectiva?',
    'teve dificuldade para pegar no sono ou permanecer dormindo, ou dormiu '
        'mais do que de costume?',
    'se sentiu cansado(a) ou com pouca energia?',
    'teve falta de apetite ou comeu demais?',
    'se sentiu mal consigo mesmo(a), ou achou que é um fracasso ou que '
        'decepcionou sua família ou a si mesmo(a)?',
    'teve dificuldade para se concentrar nas coisas, como ler o jornal ou ver '
        'televisão?',
    'teve lentidão para se movimentar ou falar, a ponto de outras pessoas '
        'perceberem? Ou o oposto: esteve tão agitado(a) que ficou andando de '
        'um lado para o outro muito mais do que de costume?',
    'pensou em se ferir de alguma maneira ou que seria melhor estar morto(a)?',
  ];

  static const opcoes = <OpcaoPhq9>[
    OpcaoPhq9('Nenhuma vez', 0),
    OpcaoPhq9('Alguns dias', 1),
    OpcaoPhq9('Mais da metade dos dias', 2),
    OpcaoPhq9('Quase todos os dias', 3),
  ];

  /// Índice da pergunta 9, sobre se ferir (RN23).
  static const indicePerguntaSeFerir = 8;

  /// Texto completo da pergunta [indice] (0 a 8), como aparece na tela.
  static String textoCompleto(int indice) => '$enunciado ${perguntas[indice]}';
}

/// Uma opção de resposta do PHQ-9, com o valor que entra no escore.
class OpcaoPhq9 {
  const OpcaoPhq9(this.texto, this.valor);

  final String texto;
  final int valor;
}
