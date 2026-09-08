# Benchmark da Atividade 02: Pesquisa, Benchmark e Personas

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Valor da atividade: 2,0 pontos (Benchmark: 0,40)

| Campo | Preenchimento |
|---|---|
| Seção | Benchmark (item 3 da Atividade 02) |
| Autor desta seção | Franck Patrick Hora Vasconcelos |
| Data | 08/09/2026 |

## Critério de escolha das soluções

O Respira reúne três frentes que normalmente aparecem separadas: alívio imediato (respiração guiada), autoconhecimento (diário de humor e PHQ-9) e acesso à rede de apoio (CVV). Por isso, em vez de comparar três apps genéricos de bem-estar, o benchmark foi montado com uma solução forte em cada uma dessas frentes. Isso permite avaliar, frente a frente, o que já existe de bom em cada pilar e onde o Respira precisa se diferenciar.

Essa escolha também dialoga com a pesquisa do projeto (docs/pesquisa.md): a exclusão digital de parte do público e a ausência de instrumentos validados nos apps analisados reforçam por que o Respira precisa ser offline e cientificamente embasado, não apenas mais uma opção de bem-estar. As personas Marina Souza e Lucas Andrade (docs/personas.md) representam, respectivamente, o cenário de crise e o de uso diário que cada solução comparada resolve apenas parcialmente.

## 1. Daylio (diário de humor e hábitos)

### Principais funcionalidades
Registro rápido de humor por emojis, marcação de atividades do dia, gráficos e estatísticas de correlação entre humor e atividades, lembretes de registro e exportação de dados.

### Pontos positivos
Não exige cadastro nem login para uso básico, funciona totalmente offline e o registro leva poucos segundos, o que reduz a barreira de entrada. É exatamente o problema de baixo esforço que o Respira também precisa resolver para o público em crise ou com atenção reduzida.

### Pontos negativos
É um diário genérico de humor e hábitos, sem qualquer instrumento clínico validado (não aplica PHQ-9, GAD-7 ou equivalente) e sem nenhum canal de ajuda ou encaminhamento em caso de crise. O aplicativo assume que o usuário já sabe cuidar de si; ele não entrega uma técnica de regulação no momento do desconforto, apenas registra o dado depois.

### Aspectos de interface/experiência
Interface colorida e gamificada (sequências, conquistas, comparação de progresso), o que funciona bem para hábito, mas é o oposto do tom "sem julgamento e sem cobrança" que o estudo de caso do Respira exige. Mecanismos de sequência e conquista introduzem justamente a lógica de cobrança que o Respira quer evitar.

### O que pode ser aproveitado ou melhorado no Respira
Aproveitar: o registro por emojis grandes em poucos toques e a ausência de login obrigatório.
Melhorar: o Respira precisa manter esse mesmo baixo esforço de registro, mas sem elementos de gamificação/comparação, e complementar o diário com instrumento validado (PHQ-9) e ação imediata (respiração), coisas que o Daylio não oferece.

## 2. Calm

### Principais funcionalidades
Meditações guiadas, exercícios de respiração com animação visual, histórias para dormir, músicas para relaxamento e foco, masterclasses sobre bem-estar e um check-in diário de humor.

### Pontos positivos
Tem uma das referências mais conhecidas de exercício de respiração guiada por animação visual (um círculo que expande e contrai), com identidade visual calma e gradientes suaves, próxima da proposta visual do Respira. É reconhecido pela qualidade da experiência sensorial voltada à calma.

### Pontos negativos
A maior parte do conteúdo, incluindo praticamente todas as meditações, sons e masterclasses, fica atrás de assinatura paga. Não possui nenhum instrumento de rastreio validado (PHQ-9 ou GAD-7) nem qualquer canal de encaminhamento para ajuda profissional ou de emergência. O aplicativo é pesado, com áudios e vídeos que exigem espaço de armazenamento e boa conexão de internet para streaming, o que dificulta o uso em aparelhos básicos.

### Aspectos de interface/experiência
Interface visualmente sofisticada, com animações e sons pensados para uma experiência prolongada e imersiva, em geral usada com fones de ouvido em momentos de calma. Não foi desenhada para o cenário de crise com atenção reduzida, já que a navegação entre categorias de conteúdo passa por várias telas antes de chegar ao exercício desejado.

### O que pode ser aproveitado ou melhorado no Respira
Aproveitar: a ideia da animação de respiração como elemento central e calmante da experiência, e a identidade visual baseada em cores suaves.
Melhorar: o Respira precisa entregar esse mesmo efeito calmante sem depender de assinatura, sem exigir download de conteúdo pesado e sem múltiplas telas de navegação. A respiração guiada precisa estar disponível de graça, leve e a poucos toques, ao contrário do Calm.

## 3. CVV, Centro de Valorização da Vida (chat, e-mail e telefone 188)

### Principais funcionalidades
Apoio emocional gratuito, sigiloso e voluntário por telefone (188), chat e e-mail, funcionando 24 horas, com foco em prevenção do suicídio e escuta sem julgamento.

### Pontos positivos
É a própria referência de acolhimento humano que o estudo de caso do Respira coloca no centro do produto: gratuito, sigiloso, disponível a qualquer hora, sem exigir identificação. Também é a fonte da frase-guia do Respira ("escutar sem julgar").

### Pontos negativos
Não é um aplicativo de autocuidado: não existe diário de humor, questionário de rastreio, técnica de respiração ou qualquer recurso de uso diário. O acesso ao chat pelo site normalmente passa por uma página institucional com várias informações antes do início da conversa, o que é apropriado para quem já decidiu buscar ajuda, mas exige mais passos do que o "um toque a partir da tela inicial" que o Respira define como requisito para a situação de crise.

### Aspectos de interface/experiência
Site e canais pensados para atendimento humano, não para navegação rápida em situação de pânico; não há um atalho de discagem integrado a outro aplicativo de autocuidado, o que obriga o usuário a sair do que estava usando (se estivesse usando algum) e procurar o canal do zero.

### O que pode ser aproveitado ou melhorado no Respira
Aproveitar: o próprio serviço do CVV, integrado como o canal oficial de emergência do Respira (telefone 188 com discagem por toque, cacheado localmente).
Melhorar: o Respira remove a etapa de "procurar o canal" ao deixar o botão do CVV fixo, vermelho e a um toque em qualquer tela, algo que nenhum canal isolado do CVV consegue oferecer sozinho, já que ele não está embutido dentro da rotina diária do usuário.

## Síntese: o que o Respira pode fazer de diferente ou melhor

Nenhuma das três soluções cobre as três frentes ao mesmo tempo: o Daylio resolve o registro rápido mas não tem rastreio validado nem canal de ajuda; o Calm entrega uma respiração guiada e uma identidade visual calma muito bem cuidadas, mas coloca quase tudo atrás de assinatura, não tem rastreio validado nem emergência de um toque; o CVV é o canal de ajuda humana mas não tem nenhuma ferramenta de autocuidado. O Respira se diferencia por entregar as três coisas juntas, de graça, sem login e sem cadastro: diário de humor tão rápido quanto o do Daylio, respiração guiada tão cuidada quanto a do Calm, complementada por um rastreio validado (PHQ-9) que nenhum dos três oferece, e o acesso ao CVV tão direto quanto o Respira consegue tornar um canal que, sozinho, exige mais passos. A diferença central não é ter uma funcionalidade nova, é remover todo atrito entre essas três frentes para que funcionem como uma coisa só, inclusive offline e em aparelhos básicos.
