# Atividade 01: Análise do Estudo de Caso

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Valor: 1,0 ponto

| Campo | Preenchimento |
|---|---|
| Nome do projeto | App Respira |
| Turma | Programação para Dispositivos Móveis, GP0029VNO07A |
| Integrantes | Franck Patrick Hora Vasconcelos, Murilo Pedral Mota, Rafael Menezes Gonçalves, Rene Mendonça Marinho |
| Repositório GitHub | https://github.com/rafael-men/App-Respira |
| Data | 01/09/2026 |

## 1. Problema

### Qual problema o aplicativo pretende ajudar a solucionar?

O Respira parte do sofrimento causado pelos transtornos mentais comuns, principalmente a ansiedade e a depressão. Dentro desse tema, o estudo de caso deixa ver cinco problemas mais específicos:

- O estigma, que faz muita gente deixar de procurar ajuda mesmo quando ela existe. Por isso o aplicativo precisa ser acolhedor, e não apenas funcional.
- A ausência de identificação, já que muitas pessoas convivem com os sintomas sem nenhum instrumento que as ajude a perceber a intensidade e a evolução do que sentem.
- A falta de um recurso imediato nos momentos de maior sofrimento, quando a pessoa está em crise de ansiedade ou pânico e não tem à mão nem uma técnica de regulação nem um canal de ajuda.
- As barreiras de acesso tecnológico e financeiro, porque o público inclui universitários, professores e pacientes de CAPS, que nem sempre têm aparelhos de ponta ou internet estável.
- A insegurança quanto à privacidade, porque registrar humor e respostas de questionário significa confiar dados de saúde mental a um aplicativo, e o medo de vazamento afasta o usuário antes mesmo do primeiro uso.

### Por que esse problema é relevante?

Ansiedade e depressão estão entre os transtornos mais frequentes, e entre perceber que algo não vai bem e conseguir atendimento costuma existir um intervalo longo, no qual a pessoa fica sem qualquer apoio. É exatamente esse intervalo que o aplicativo ocupa. Some-se a isso o fato de o público descrito no caso viver sob pressão contínua, seja por prazos e provas, seja pela rotina de sala de aula, seja por um tratamento em andamento.

Há ainda um fator de gravidade que o próprio estudo de caso reconhece ao colocar o CVV no centro do produto: em um momento de crise, ter ou não um canal de ajuda ao alcance da mão faz diferença real. Não é à toa que o documento classifica o Respira como o projeto mais sensível da turma.

### Qual é a principal necessidade que a solução deverá atender?

Reduzir a distância entre a pessoa e o cuidado. Isso vale para a distância técnica, que é encontrar o número do CVV, entender o próprio quadro e ter uma técnica de respiração disponível, e para a distância simbólica, que é sentir que dá para registrar o que se sente sem ser julgado ou exposto. Na prática, a necessidade se traduz em entregar apoio útil em poucos segundos, funcionando em aparelho simples, sem internet e sem exigir cadastro.

## 2. Público e usuários

Os quatro públicos indicados no estudo de caso não se separam apenas pelo perfil demográfico. O que muda de verdade entre eles é a relação com a rede de saúde: parte deles nunca teve contato com um serviço de saúde mental e parte já está em acompanhamento. Essa diferença altera o papel que o aplicativo cumpre em cada caso.

| Público | Relação com o aplicativo | Principais necessidades | Situação de uso |
|---|---|---|---|
| Adultos (público geral) | Porta de entrada, em geral sem vínculo com CAPS. Pode ser o primeiro contato com um instrumento de rastreio. | Entender se o que sentem tem nome e intensidade, ter alívio pontual e não se sentir rotulado. | Em casa ou no trabalho, em momentos de tensão ou no fim do dia, para registrar o humor. |
| Universitários | Uso curto e frequente, encaixado nas brechas da rotina. | Ferramenta rápida e discreta, resolvida em poucos toques, com noção da evolução ao longo do semestre. | Entre aulas, antes de provas e apresentações, à noite. Muitas vezes em aparelhos modestos e com dados limitados. |
| Professores | Adultos em contexto de trabalho, expostos a demanda emocional constante. | Uso discreto, que não chame atenção no ambiente profissional, e regulação rápida entre atividades. | Em intervalos curtos, com necessidade de silêncio e sem notificação visível. |
| Pacientes de CAPS | Já vinculados à RAPS. Para eles o aplicativo é apoio entre atendimentos, nunca substituto do cuidado. | Continuidade do acompanhamento, registro do humor entre consultas e acesso imediato ao CVV. | Uso diário de manutenção, com diário e respiração, e uso emergencial em momentos de crise. |

### Dois perfis de engajamento

Além dos quatro públicos, o caso descreve dois modos de uso que atravessam todos eles e que, na prática, orientam mais o projeto do que a segmentação demográfica.

- Engajamento emergencial, que é o usuário em crise. Ele abre o aplicativo durante uma crise de ansiedade ou pânico, com atenção reduzida e sem paciência para navegar. Aqui cada toque a mais é uma barreira, o que explica o CVV a um toque da tela inicial e a animação de respiração começando sozinha.
- Engajamento diário, que é o usuário em manutenção. Ele usa o diário de humor e a respiração como rotina. O valor está na constância e em conseguir ver o progresso, o que explica o questionário semanal e o gráfico de evolução.

A consequência para o projeto é que a mesma tela inicial precisa servir aos dois perfis, sem obrigar o usuário a escolher logo de cara. O acesso de emergência fica fixo e sempre visível, enquanto o conteúdo de rotina ocupa o corpo da interface.

## 3. Contexto de uso

O estudo de caso descreve condições de uso bem específicas, e cada uma delas vira uma restrição concreta de desenvolvimento.

| Dimensão | O que o estudo de caso estabelece | Implicação para o desenvolvimento |
|---|---|---|
| Ambiente | Ambientes internos, casa e trabalho. | Uso discreto e silencioso, sem expor a quem está por perto o que o usuário registra. |
| Momento de utilização | Uso rotineiro, com diário e respiração, e uso em momentos de crise. | A navegação precisa atender aos dois ritmos ao mesmo tempo, sem exigir uma escolha inicial. |
| Condição do usuário | Em crise, atenção reduzida. Em manutenção, atenção normal. | Textos curtos, hierarquia visual óbvia, uma decisão por tela e questionário apresentado passo a passo. |
| Dispositivo | O aplicativo deve ser testado em smartphones básicos. | Animações leves, consumo de memória controlado, poucas dependências e teste em aparelho real, não só em emulador. |
| Conectividade | Diário de humor offline e número do CVV em cache local, discando sem sinal de dados. | Persistência local como padrão, com sincronização posterior. Nenhuma função crítica pode depender da rede. |
| Iluminação | A tela deve ser suave para leitura noturna. | Paleta sem contraste agressivo, brilho controlado e suporte a tema escuro, evitando fundos brancos intensos. |
| Nível de atenção | A funcionalidade principal deve ocorrer em até 3 interações. | Abrir o app, tocar no card Respirar e tocar em Voltar. Qualquer etapa extra precisa de justificativa. |
| Situação de urgência | Botão do CVV a 1 toque da tela inicial, fixo no topo e em vermelho vivo. | O elemento de emergência é global e persistente, nunca escondido em menu ou rodapé. |
| Estímulos sensoriais | Sem vibração excessiva, com silêncio total permitido, sem animação rápida e sem pop-up. | Feedback háptico opcional e desativável, notificações não invasivas e nenhuma interrupção modal. |
| Energia | A tela de respiração pode ficar aberta por vários minutos, com consumo mínimo de bateria. | Animação contínua e leve, sem redesenho desnecessário nem processo em segundo plano durante a sessão. |

## 4. Objetivo e proposta de valor

O objetivo do Respira é ser um espaço digital seguro para cuidado emocional, reunindo três coisas que normalmente aparecem separadas: uma ferramenta de alívio imediato, um instrumento de rastreio com validade científica e um caminho direto para a rede de apoio.

O benefício para o usuário aparece em três níveis. No nível imediato, a respiração guiada no padrão 4-7-8 entrega uma técnica concreta de regulação em segundos, sem preparo nenhum. No nível do autoconhecimento, o diário de humor e o PHQ-9 semanal transformam uma sensação difusa de mal-estar em informação organizada, que dá para acompanhar ao longo do tempo e até levar para uma conversa com um profissional. No nível da segurança, a presença permanente do CVV garante que, no pior momento, o caminho até a ajuda humana esteja a um toque.

A proposta de valor, portanto, não é substituir o cuidado profissional. É diminuir a distância entre a pessoa e esse cuidado, tanto a distância técnica quanto a distância simbólica criada pelo estigma.

## 5. Personalidade, identidade e experiência

### 5.1 Palavras conceituais

As palavras vinculadas ao projeto, que são mindfulness, PHQ-9, GAD-7, CVV, CAPS, setembro amarelo e RAPS, vêm de dois mundos diferentes. Metade pertence ao vocabulário do bem-estar e da atenção plena, e a outra metade ao vocabulário clínico e da saúde pública. O aplicativo precisa sustentar as duas dimensões: ter a leveza de um produto de wellness sem perder a seriedade de quem aplica escalas validadas e encaminha para serviços reais. Na prática, os termos clínicos ficam na documentação e na fundamentação do projeto, mas não podem dominar a linguagem da interface, sob risco de reforçar justamente o estigma que a missão pretende reduzir.

### 5.2 Personalidade da identidade

A identidade é calma e translúcida, com gradientes suaves de lilás e azul e animações lentas com efeito de respiração. Essas escolhas não são decorativas, e o próprio estudo de caso as justifica pela função: as animações de 4 a 7 segundos induzem a respiração diafragmática, e a transição do roxo profundo para o azul claro representa visualmente a passagem do estado de ansiedade para a calma. A identidade visual, aqui, faz parte do mecanismo da solução, e não é um acabamento aplicado no fim.

### 5.3 Tom da interface e da experiência

O tom é empático e livre de julgamentos, e isso vira decisão verificável: o questionário aparece um passo por vez para não sobrecarregar o usuário, as notificações são motivacionais mas não invasivas, e não existem pop-ups nem animações rápidas capazes de gerar sobressalto. Um aplicativo que se propõe a acalmar não pode ter uma interface que compete por atenção. O mesmo vale para o texto: o resultado do PHQ-9 precisa ser comunicado sem linguagem alarmista e sem tom de diagnóstico fechado, sempre com o encaminhamento à rede de apoio como saída natural.

### 5.4 Como o aplicativo quer ser lembrado

A frase escolhida, "o aplicativo que te escuta sem te julgar", funciona como critério de decisão do projeto inteiro. Escutar implica registro, memória e acolhimento, ou seja, diário de humor e gráfico de progresso. Não julgar implica anonimato por padrão, ausência de metas, ausência de cobrança e nenhum mecanismo de comparação ou pontuação. Sempre que houver dúvida sobre uma funcionalidade, a frase resolve: se o recurso cobra, compara ou expõe, ele contradiz a identidade do produto.

## 6. Funcionalidades e características já definidas

_(seção sob responsabilidade de Rene Mendonça Marinho)_

## 7. Restrições e condições

_(seção sob responsabilidade de Rene Mendonça Marinho)_

## 8. Pontos de atenção

_(seção sob responsabilidade de Rene Mendonça Marinho)_
