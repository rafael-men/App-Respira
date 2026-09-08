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

## 2. Youper

### Principais funcionalidades
Assistente de saúde emocional baseado em IA para conversas guiadas por técnicas de terapia cognitivo-comportamental (TCC), check-in diário de humor, questionários de rastreio de ansiedade e depressão, e gráficos de evolução emocional.

### Pontos positivos
Combina autoconhecimento (check-in de humor e questionários de rastreio) com ferramentas de regulação guiadas pela IA, o que é próximo da proposta de três camadas do Respira (alívio, autoconhecimento, rede de apoio). O conteúdo é fundamentado em técnicas terapêuticas reconhecidas, não apenas em bem-estar genérico.

### Pontos negativos
Exige criação de conta para acompanhar o progresso e depende de conexão com a internet para funcionar, já que a conversa com a IA acontece em nuvem. Boa parte dos recursos aprofundados fica atrás de assinatura paga, e não há um recurso de emergência de um toque: em caso de crise, o usuário precisaria digitar e conversar com o assistente, sem um botão fixo de acesso a um canal humano.

### Aspectos de interface/experiência
Interface amigável, baseada em conversa por chat, o que funciona bem para reflexão em ritmo tranquilo, mas exige digitação e leitura de várias mensagens antes de chegar a qualquer alívio. Isso é o oposto do cenário de crise com atenção reduzida que o Respira também precisa atender em até 3 interações.

### O que pode ser aproveitado ou melhorado no Respira
Aproveitar: a ideia de unir check-in de humor com questionário de rastreio validado na mesma jornada.
Melhorar: o Respira deve entregar essa combinação sem exigir conta, sem assinatura, sem depender de internet e sem precisar de uma conversa por chat. O "alívio imediato" precisa estar disponível de graça, offline e em poucos toques, não atrás de uma interação por texto com uma IA.

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

Nenhuma das três soluções cobre as três frentes ao mesmo tempo: o Daylio resolve o registro rápido mas não tem rastreio validado nem canal de ajuda; o Youper une rastreio e regulação mas depende de internet, conta e conversa por chat, sem emergência de um toque; o CVV é o canal de ajuda humana mas não tem nenhuma ferramenta de autocuidado. O Respira se diferencia por entregar as três coisas juntas, de graça, sem login e sem cadastro: diário de humor tão rápido quanto o do Daylio, rastreio validado (PHQ-9) e respiração guiada tão fundamentados quanto os do Youper, e o acesso ao CVV tão direto quanto o Respira consegue tornar um canal que, sozinho, exige mais passos. A diferença central não é ter uma funcionalidade nova, é remover todo atrito entre essas três frentes para que funcionem como uma coisa só, inclusive offline e em aparelhos básicos.
