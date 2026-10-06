# Atividade 04: Justificativas do Protótipo de Alta Fidelidade

Projeto Respira, aplicativo de saúde mental e apoio emocional
Disciplina: Programação para Dispositivos Móveis | Valor da atividade: 2,0 pontos

| Campo | Preenchimento |
|---|---|
| Seção | Justificativas (item 2.4 da Atividade 04) |
| Integrantes | Franck Patrick Hora Vasconcelos, Murilo Pedral Mota, Rafael Menezes Gonçalves, Rene Mendonça Marinho |
| Data | 22/09/2026 |

## 1. Escolha das cores (paleta e contraste)

A paleta parte diretamente da seção 5.2 do estudo de caso, que já definia a identidade como "calma e translúcida, com gradientes suaves de lilás e azul" e explicava que a transição do roxo profundo ao azul claro representa visualmente a passagem do estado de ansiedade para a calma. O protótipo de alta fidelidade formaliza essa descrição em tokens de cor reutilizáveis:

| Papel | Cor | Uso |
|---|---|---|
| Roxo profundo (purple900) | #3D2E6B | Ponta "ansiedade" do gradiente de marca; texto de maior destaque |
| Roxo médio (purple700) | #5B4A94 | Botões primários, ícones de destaque, títulos |
| Lilás (purple500) | #8778C3 | Meio do gradiente; acentos secundários |
| Azul (blue400) | #9DC2ED | Transição para a calma |
| Azul claro (blue300) | #C3DCF5 | Ponta "calma" do gradiente; fundos suaves |

Essa progressão roxo→azul é usada de forma literal na Tela 04 (Respiração Guiada), o único fundo em tela cheia com o gradiente de marca: como o círculo de respiração já fica em primeiro plano nessa tela, o próprio fundo pôde assumir a transição de cor que o estudo de caso pede, reforçando com a interface inteira o que a animação já comunica.

Fora dessa tela, a paleta aparece de forma comedida: fundo neutro muito claro (#F6F5FC), cartões brancos com sombra suave (10% de opacidade) e texto em cinza-arroxeado (#2E2A45) em vez de preto puro. Essa escolha atende diretamente à restrição de contexto de uso do estudo de caso (seção 3, linha "Iluminação"): "paleta sem contraste agressivo, brilho controlado... evitando fundos brancos intensos". Um branco puro (#FFFFFF) sobre um fundo também branco teria contraste insuficiente para hierarquia visual; o fundo #F6F5FC cria separação sutil sem recorrer a bordas pesadas.

Duas cores fogem da família roxo-azul por necessidade funcional, não estética:

- *Vermelho de emergência* (#E1483D, com variante mais escura #C23B31 no gradiente do botão): usado exclusivamente no botão SOS CVV, na tela de confirmação de chamada e no Botão de Pânico. O estudo de caso exige "vermelho vivo" (seção 7, linha "Navegação") justamente para que esse elemento nunca seja confundido com uma ação comum — é a única cor do sistema com essa função de alarme, o que preserva seu significado. Um vermelho mais claro ou dessaturado correria o risco de se misturar ao restante da paleta lilás e perder a urgência que RF09 e RF13 exigem.
- *Escala de humor* (do diário): os cinco emojis de humor usam uma progressão de #E1483D (muito mal) a #5B4A94 (muito bem), passando por laranja suave, lilás-cinza e azul. Em vez de introduzir verde/amarelo (cores fora da paleta de marca), a escala reaproveita o mesmo eixo "alerta → calma" do gradiente de respiração, de modo que o usuário associa intuitivamente "mais calmo" a "mais próximo do azul/roxo da marca" — reforçando a mesma metáfora em duas funcionalidades diferentes (F01 e F02).

Todos os pares texto/fundo do sistema foram verificados a olho para manter leitura confortável mesmo em tela pequena e com pouca luz (contexto de uso descrito na seção 3 do estudo de caso): texto principal #2E2A45 sobre fundo #F6F5FC ou cartões brancos, texto secundário #6E6788 reservado para legendas e metadados, nunca para conteúdo essencial. Na Tela 04 (fundo gradiente escuro), o texto e os ícones passam para branco, e o círculo central de "Inspire" usa fundo quase opaco (95%) exatamente para garantir contraste alto no ponto de maior atenção da tela, coerente com RNF02 (sem elementos que exijam esforço de leitura em situação de crise).

## 2. Tipografia (hierarquia e legibilidade)

Foram escolhidas duas famílias, ambas gratuitas e disponíveis nas bibliotecas padrão do Figma e do Flutter (via Google Fonts), o que evita qualquer dependência de licenciamento pago no momento da implementação em Unidade II:

- *Poppins* (geométrica, levemente arredondada) para títulos, nomes de tela, rótulos de botão e números de destaque (como o escore do PHQ-9 e o "188" do CVV). Poppins tem um traço amigável sem ser infantil, o que ajuda a sustentar o tom "empático e livre de julgamentos" pedido na seção 5.3 do estudo de caso sem parecer um aplicativo de entretenimento.
- *Inter* (humanista, desenhada para telas pequenas) para corpo de texto, descrições, opções de formulário e legendas. Inter foi escolhida por sua legibilidade documentada em tamanhos pequenos (12–14px), relevante porque RNF08 exige teste em aparelhos de entrada, onde telas menores e mais densas tornam a legibilidade um requisito técnico, não só estético.

A hierarquia de tamanhos segue uma escala pequena e previsível, para que qualquer tela nova criada na Unidade II possa reaproveitar os mesmos níveis sem redesenhar do zero:

| Nível | Fonte/peso | Tamanho | Uso |
|---|---|---|---|
| Título de tela | Poppins SemiBold/Bold | 17–20px | Nome da AppBar |
| Número de destaque | Poppins Bold | 34–48px | Escore do PHQ-9, "188" do CVV |
| Título de cartão | Poppins SemiBold | 15–16px | Nome dos cards da Home, do resultado |
| Corpo | Inter Regular/Medium | 13–15px | Perguntas, descrições, opções |
| Legenda | Inter Regular | 11–12,5px | Metadados, timestamps, texto de apoio |

Nenhum texto do protótipo é menor que 11px, e os textos de maior responsabilidade (perguntas do PHQ-9, aviso do Botão de Pânico, confirmação de ligação ao CVV) usam Inter Regular 13,5–16,5px com altura de linha generosa (1,4–1,5×), o que atende à persona Marina em crise, cuja atenção está reduzida (seção 2 do estudo de caso) e não pode depender de textos pequenos ou densos para decidir algo urgente.

## 3. Organização das informações (disposição e fluxo visual)

A Tela 01 mantém a mesma estrutura validada no protótipo de baixa fidelidade — AppBar fixa, pergunta de abertura, grade 2×2 de funcionalidades, área de identidade visual — porque essa estrutura já havia sido pensada para atender aos dois perfis de engajamento descritos no estudo de caso (seção 2): a mesma tela inicial precisa servir tanto a quem está em crise (engajamento emergencial) quanto a quem usa o app por rotina (engajamento diário), sem obrigar a escolha de um caminho logo de cara. A alta fidelidade reforça essa leitura com hierarquia visual real: os quatro cards têm o mesmo peso visual entre si (nenhuma funcionalidade de rotina é destacada sobre outra), enquanto o botão SOS CVV se distingue por cor, forma (círculo) e posição fixa — a única ação da tela com tratamento visual de urgência, coerente com o ponto de atenção 8.2 do estudo de caso.

Dentro de cada tela, a disposição segue um padrão consistente: AppBar → contexto/pergunta → conteúdo principal → ação primária no rodapé. Esse padrão reduz a carga cognitiva de reaprender a interface a cada tela nova, o que é particularmente importante para a persona Lucas, que usa o app em sessões curtas entre uma aula e outra (docs/personas.md) e não tem tempo para reaprender onde as coisas ficam.

A área de identidade visual da Tela 01 (antes apenas um retrato pontilhado com legenda no wireframe) virou, na alta fidelidade, um cartão real com gradiente suave, formas orgânicas translúcidas e a frase "Respire fundo. Este é um espaço seguro, sem julgamentos." — uma aplicação direta da frase-guia definida na seção 5.4 do estudo de caso ("o aplicativo que te escuta sem te julgar"). Ela ocupa a parte inferior da tela, depois das funcionalidades, para não competir com as ações principais, mas ainda assim reforçar a identidade em todo acesso à Home.

