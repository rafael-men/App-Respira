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

## 4. Navegação (fluxos, menus e facilidade de localização)

A navegação do protótipo de alta fidelidade é idêntica, em estrutura, à validada na baixa fidelidade: a Tela 01 é o único ponto de entrada para Diário, Respirar, PHQ-9 e Configurações, e o botão SOS CVV fica acessível a partir de qualquer tela, sempre no mesmo canto superior direito, sempre com a mesma cor e o mesmo rótulo. Essa previsibilidade é o que garante RNF01 (função principal em até 3 interações) e a exigência de "1 toque a partir de qualquer tela" para o CVV (RF09, seção 8.2 do estudo de caso): não há menu para abrir, não há tela intermediária, o botão está sempre no mesmo lugar físico da tela, o que importa quando o usuário está com atenção reduzida.

Todas as telas secundárias (Diário, Histórico, Respiração, PHQ-9, Configurações) usam o mesmo padrão de retorno — seta "‹" no canto superior esquerdo da AppBar, sempre voltando à tela de origem — exceto as duas telas de confirmação crítica (Chamada ao CVV e Botão de Pânico), que substituem a seta por um botão "Cancelar" explícito no rodapé. Essa exceção é proposital: em ações que envolvem uma ligação de emergência ou a exclusão permanente de dados, um toque acidental no canto da tela (comum em uso com uma mão só, ou em situação de crise) não deve ser a única forma de sair da tela — o "Cancelar" exige uma ação de leitura e confirmação, reduzindo o risco de saída não intencional em um momento sensível.

## 5. Componentes (elementos de UI utilizados)

O protótipo define um pequeno conjunto de componentes reutilizáveis, para que a implementação em Flutter (Unidade II) possa mapear cada um a um widget único em vez de recriar estilos tela a tela:

- Cartão (card): fundo branco, cantos arredondados de 20px, sombra suave. Usado nos cards da Home, no resultado do PHQ-9 e no gráfico de evolução.
- Botão primário: preenchimento em gradiente roxo, texto branco em Poppins SemiBold. Usado em ações de avanço no fluxo (Salvar registro, Próxima).
- Botão de perigo: preenchimento em gradiente vermelho. Usado exclusivamente em Ligar agora e Apagar tudo — as duas únicas ações irreversíveis ou de emergência do app, reservando o vermelho para esse papel específico.
- Botão contorno/texto: usado em ações secundárias (Voltar ao início, Cancelar), sem competir visualmente com a ação primária da tela.
- Seletor de humor (chip circular): estado "não selecionado" com contorno fino e ícone colorido; estado "selecionado" com preenchimento sólido, leve aumento de escala e sombra — demonstra visualmente o estado ativo exigido pelo item 2.2 da Atividade 04.
- Opção de rádio (PHQ-9): linha inteira tocável, com destaque de fundo quando selecionada, não apenas o círculo do rádio — aumenta a área de toque, importante em uso com atenção reduzida.
- Toggle (interruptor): usado nas duas preferências de Configurações (tema escuro, notificações), com estado ligado/desligado claramente diferenciado por cor e posição.
- Barra de progresso: usada no PHQ-9 para mostrar "Pergunta X de 9", dando ao usuário uma expectativa clara de quanto falta — reduz a ansiedade de não saber a duração de um questionário sobre saúde mental.
- Gráfico de linha: usado no histórico de PHQ-9, com pontos discretos e traço em gradiente de marca, mantendo a mesma identidade visual mesmo em um componente de dado.

## 6. Acessibilidade (conformidade com padrões de inclusão)

O estudo de caso já define, na seção 3 (linha "Estímulos sensoriais") e no RNF02, que o app não pode usar vibração excessiva, animações rápidas ou pop-ups, e deve funcionar com feedback háptico desativado e em silêncio total. O protótipo de alta fidelidade segue essa exigência de três formas concretas:

* Nenhuma confirmação crítica (chamada ao CVV, exclusão de dados) usa um pop-up modal sobreposto à tela: ambas são telas de página inteira, navegáveis como qualquer outra, o que evita o "susto" de um elemento flutuante aparecendo de repente.
* Todos os alvos de toque (botões, cards, opções de rádio, linhas de configuração) têm altura mínima de 48–56px, bem acima do mínimo recomendado de 44px, considerando o uso por pessoas com atenção reduzida ou em ambientes com pouca luz.
* O contraste de texto evita tanto o preto puro sobre branco puro (excesso de contraste, cansativo em uso noturno) quanto tons pastéis de baixo contraste (ilegíveis) — um meio-termo verificado visualmente em cada tela, com reforço adicional de peso de fonte (SemiBold/Bold) em vez de apenas cor para indicar seleção (por exemplo, na opção do PHQ-9 selecionada e no chip de humor ativo), o que ajuda usuários com baixa percepção de cor a identificar o estado sem depender só da cor.

## 7. Decisões relacionadas ao contexto de uso

O contexto de uso do Respira (estudo de caso, seção 3) é o ponto de partida de praticamente todas as decisões acima, mas duas merecem destaque específico:

* Leitura noturna e tema escuro (RF15, F10): o protótipo de alta fidelidade inclui, além das nove telas principais, uma variante de estado da Tela 01 com o tema escuro ativado (arquivo Tela_HD_01_TemaEscuro.svg, também presente no PDF como página de estado). Ela reaproveita a mesma paleta de marca em versão mais escura e saturada (fundo #191627, cartões #241F38), mantendo o mesmo gradiente roxo-azul como acento, em vez de simplesmente inverter as cores — o que preservaria a identidade da marca mesmo à noite, coerente com a exigência de "suporte a tema escuro, evitando fundos brancos intensos" (seção 3, linha "Iluminação").
* Tela de respiração como caso especial de contexto de uso: é a única tela pensada para permanecer aberta por vários minutos (RNF04), por isso não tem nenhuma animação decorativa além do próprio círculo de respiração — sem elementos que se movam sem propósito, o que ajuda tanto no consumo de bateria quanto em evitar estímulos visuais desnecessários durante uma sessão de regulação emocional.

A escala de mockup (402×874px) corresponde a um aparelho de entrada/intermediário comum, não ao maior iPhone disponível, o que mantém o desenho honesto em relação à exigência de RNF08 (teste em ao menos um Android real de entrada): nenhum elemento do layout depende de uma tela grande para funcionar.
