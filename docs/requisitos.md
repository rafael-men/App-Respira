# Atividade 03: Funcionalidades e Requisitos

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Valor da atividade: 2,0 pontos

| Campo | Preenchimento |
|---|---|
| Seção | Funcionalidades e Requisitos (Atividade 03) |
| Autores | Rene Mendonça Marinho (Funcionalidades e Priorização), Franck Patrick Hora Vasconcelos (Requisitos funcionais e consolidação), Murilo Pedral Mota (Requisitos não funcionais), Rafael Menezes Gonçalves (CRUD) |
| Data | 14/09/2026 |

Este documento transforma em funcionalidades e requisitos o que já foi levantado nas atividades anteriores: o problema e as restrições descritos no estudo de caso (`docs/estudo-de-caso.md`), os dados da pesquisa (`docs/pesquisa.md`), as personas Marina Souza e Lucas Andrade (`docs/personas.md`) e as lacunas identificadas no benchmark (`docs/benchmark.md`). Nenhuma funcionalidade aqui é nova em relação ao que já havia sido definido; o trabalho desta atividade é detalhar, numerar e priorizar o que antes estava descrito em prosa.

## 1. Funcionalidades

### F01 — Diário de humor com emojis
**Descrição:** tela em que o usuário registra como está se sentindo tocando em um emoji grande (de muito ruim a muito bem), podendo adicionar uma nota curta opcional. O registro é salvo com data e hora, consultável depois em um histórico.
**Necessidade do usuário que atende:** Marina precisa de um registro rápido, de baixo esforço mental, mesmo em estado de atenção reduzida; Lucas quer acompanhar sua evolução emocional ao longo do semestre sem burocracia.
**Justificativa:** o estudo de caso já define essa funcionalidade como núcleo do produto (seção 6). O benchmark mostra que o Daylio valida esse formato de registro rápido e sem cadastro, mas sem os diferenciais de privacidade e integração que o Respira propõe.

### F02 — Respiração guiada no padrão 4-7-8
**Descrição:** tela com animação de um círculo que se expande e contrai em ciclos de inspirar (4s), segurar (7s) e expirar (8s), com gradiente do roxo profundo ao azul claro, iniciando sozinha ao abrir a tela.
**Necessidade do usuário que atende:** alívio imediato em crise de ansiedade, sem exigir leitura ou raciocínio complexo (cenário central da persona Marina).
**Justificativa:** o estudo de caso trata a animação como parte do mecanismo da solução, não como estética (seção 5.2); o benchmark aponta a respiração guiada do Calm como referência de qualidade, mas presa a assinatura paga e a múltiplas telas de navegação.

### F03 — Questionário PHQ-9 semanal com gráfico de progresso
**Descrição:** questionário validado, apresentado um item por tela, aplicado semanalmente; ao final, o sistema calcula o escore e mostra sua evolução em um gráfico ao longo do tempo, sem linguagem alarmista.
**Necessidade do usuário que atende:** Lucas quer entender se o que sente tem nome e intensidade; pacientes de CAPS querem levar informação organizada para a consulta.
**Justificativa:** a pesquisa confirma validade científica do PHQ-9 no Brasil, com sensibilidade de 77,5% e especificidade de 86,7% no ponto de corte 9 (`docs/pesquisa.md`, seção 3.3); nenhuma das soluções do benchmark oferece instrumento de rastreio validado.

### F04 — Acesso de emergência ao CVV (188) em 1 toque
**Descrição:** botão fixo, vermelho, na AppBar, visível em qualquer tela do aplicativo, que disca diretamente para o 188 com um único toque.
**Necessidade do usuário que atende:** Marina, em crise, precisa de ajuda humana imediata sem navegar por menus.
**Justificativa:** o CVV realizou cerca de 2 milhões de atendimentos em 2025 (`docs/pesquisa.md`, seção 3.5); o benchmark confirma que nenhuma das soluções analisadas oferece emergência de um toque de graça, o que o estudo de caso já apontava como o maior risco do produto caso essa funcionalidade falhe (seção 8.2).

### F05 — Funcionamento offline do diário e do número do CVV
**Descrição:** o número do CVV fica em cache local, permitindo discagem mesmo sem internet; os registros do diário de humor são salvos localmente e sincronizados quando houver conexão.
**Necessidade do usuário que atende:** público com aparelhos de entrada e conexão instável, como universitários e pacientes de CAPS.
**Justificativa:** 10,9% da população brasileira ainda está digitalmente excluída, e o custo do serviço é o motivo mais citado para não ter internet em casa (`docs/pesquisa.md`, seção 3.2), o que torna o offline requisito não negociável, e não otimização.

### F06 — Uso anônimo, sem cadastro obrigatório
**Descrição:** todas as funcionalidades básicas (diário, respiração, PHQ-9, CVV) funcionam sem exigir criação de conta, e-mail ou senha.
**Necessidade do usuário que atende:** reduzir o medo de exposição e julgamento, presente nas duas personas.
**Justificativa:** estudos citados na pesquisa mostram que o estigma pesa mais do que barreiras estruturais na busca por ajuda (`docs/pesquisa.md`, seção 3.1); o benchmark reforça esse padrão de baixa fricção observado no Daylio.

### F07 — Criptografia de ponta a ponta dos dados
**Descrição:** os dados do diário de humor e das respostas do PHQ-9 são armazenados de forma criptografada, tanto localmente quanto em eventual sincronização com a nuvem.
**Necessidade do usuário que atende:** confiança de que dados de saúde mental, extremamente sensíveis, não serão expostos.
**Justificativa:** um levantamento da Mozilla Foundation reprovou 22 de 32 aplicativos de saúde mental em critérios de privacidade (`docs/pesquisa.md`, seção 3.4); o estudo de caso trata isso como pré-condição de uso, não diferencial (seção 8.1).

### F08 — Botão de Pânico (exclusão total de dados)
**Descrição:** opção sempre acessível que apaga, mediante confirmação, todos os dados locais e da nuvem associados ao uso do aplicativo.
**Necessidade do usuário que atende:** exercício do direito ao esquecimento e sensação de controle sobre informações sensíveis.
**Justificativa:** coerente com o cenário de desconfiança generalizada em apps de saúde mental descrito na pesquisa (seção 3.4) e com a exigência do estudo de caso de que anonimato e controle de dados sejam condição de existência do produto.

### F09 — Notificações motivacionais não invasivas
**Descrição:** lembretes leves e opcionais para manter constância no diário e no PHQ-9, sem tom de cobrança e sem elementos de gamificação (sequências, conquistas, comparação).
**Necessidade do usuário que atende:** Lucas e professores precisam de estímulo à constância sem gerar pressão ou culpa.
**Justificativa:** o benchmark mostra que a gamificação do Daylio (sequências, conquistas) contradiz diretamente o tom "sem julgamento" que define a identidade do Respira (`docs/estudo-de-caso.md`, seção 5.4).

### F10 — Leitura noturna suave (tema claro/escuro)
**Descrição:** paleta de cores com gradientes suaves de lilás e azul, sem contraste agressivo, com alternância entre tema claro e escuro para uso noturno.
**Necessidade do usuário que atende:** uso discreto à noite ou em ambientes com pouca luz, comum às duas personas.
**Justificativa:** o estudo de caso exige explicitamente uma tela suave para leitura noturna como parte do contexto de uso (seção 3), e a identidade visual calma é descrita como parte do mecanismo da solução, não como acabamento (seção 5.2).

## 2. Requisitos funcionais

| Nº | Nome | Descrição |
|---|---|---|
| RF01 | Registro de humor | O sistema deve permitir que o usuário registre seu humor selecionando um emoji entre ao menos cinco opções, salvando data e hora automaticamente. |
| RF02 | Nota opcional no diário | O sistema deve permitir que o usuário adicione uma nota de texto curta e opcional a cada registro de humor. |
| RF03 | Histórico do diário | O sistema deve exibir o histórico de registros de humor em ordem cronológica, consultável pelo usuário a qualquer momento. |
| RF04 | Exclusão de registro do diário | O sistema deve permitir que o usuário exclua individualmente um registro do diário de humor. |
| RF05 | Animação de respiração 4-7-8 | O sistema deve exibir uma animação de um círculo que se expande e contrai nos tempos de 4s (inspirar), 7s (segurar) e 8s (expirar), iniciando automaticamente ao abrir a tela e repetindo os ciclos até o usuário tocar em "Voltar". |
| RF06 | Questionário PHQ-9 | O sistema deve apresentar as nove perguntas do questionário PHQ-9, uma por tela, permitindo que o usuário responda semanalmente. |
| RF07 | Cálculo do escore do PHQ-9 | O sistema deve calcular automaticamente o escore total do PHQ-9 ao final do questionário e armazená-lo vinculado à data de resposta. |
| RF08 | Gráfico de evolução do PHQ-9 | O sistema deve exibir um gráfico com a evolução dos escores do PHQ-9 ao longo do tempo. |
| RF09 | Acesso rápido ao CVV | O sistema deve exibir um botão fixo, vermelho, no topo de todas as telas, que disque diretamente para o número 188 com um único toque. |
| RF10 | Cache local do número do CVV | O sistema deve armazenar o número do CVV localmente, de modo que a discagem funcione mesmo sem conexão à internet. |
| RF11 | Uso sem cadastro | O sistema deve permitir o uso das funcionalidades de diário, respiração, PHQ-9 e CVV sem exigir criação de conta, e-mail ou senha. |
| RF12 | Criptografia dos dados | O sistema deve armazenar os dados do diário de humor e das respostas do PHQ-9 de forma criptografada, tanto localmente quanto em eventual sincronização com a nuvem. |
| RF13 | Botão de Pânico | O sistema deve oferecer, a partir de qualquer tela, uma opção que exclua permanentemente todos os dados locais e da nuvem associados ao uso do aplicativo, mediante confirmação do usuário. |
| RF14 | Notificações motivacionais configuráveis | O sistema deve permitir o envio de notificações push motivacionais e não invasivas, que o usuário possa ativar ou desativar. |
| RF15 | Alternância de tema | O sistema deve permitir a alternância entre tema claro e tema escuro, adequado à leitura noturna. |

## 4. CRUD

| Informação | C | R | U | D | Observação / Justificativa |
|---|---|---|---|---|---|
| Registro de humor (diário) | Sim | Sim | Não | Sim | Não há atualização de um registro já salvo: o histórico precisa refletir fielmente o estado emocional no momento do registro (RF01, RF03). Para corrigir um toque errado, o usuário exclui o registro (RF04) e cria um novo. |
| Resposta do questionário PHQ-9 | Sim | Sim | Não | Não | Cada aplicação semanal gera um novo registro de escore (RF06, RF07); respostas não são editáveis nem excluíveis individualmente, para preservar a integridade do histórico usado no gráfico de evolução (RF08). A única forma de remover esses dados é a exclusão total pelo Botão de Pânico (RF13). |
| Configurações do usuário (tema, notificações) | Sim (na primeira configuração) | Sim | Sim | Não aplicável | Preferências como tema e notificações (RF14, RF15) são sempre atualizáveis; não fazem sentido "excluídas" isoladamente, apenas redefinidas para o padrão. |
| Número de emergência do CVV (188) | Não aplicável | Sim | Não aplicável | Não aplicável | É uma informação fixa, definida pela equipe de desenvolvimento, não pelo usuário (RF09, RF10). O usuário apenas consulta e disca; alterar, atualizar ou excluir esse dado exigiria mudança de código, não uma ação dentro do app. |
| Todos os dados do usuário (uso local) | Sim (implicitamente, ao usar o app) | Sim | Não aplicável | Sim | Como não existe conta ou login (RF11), não há "atualização de perfil"; a única operação de escrita ampla sobre o conjunto de dados é a exclusão total via Botão de Pânico (RF13). |
| RF16 | Funcionamento offline do diário | O sistema deve permitir a criação e a consulta de registros do diário de humor mesmo sem conexão à internet, sincronizando os dados quando a conexão for restabelecida. |
