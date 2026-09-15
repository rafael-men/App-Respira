# Atividade 03: Funcionalidades e Requisitos

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Valor da atividade: 2,0 pontos

| Campo | Preenchimento |
|---|---|
| Seção | Funcionalidades e Requisitos (Atividade 03) |
| Autores | Rene Mendonça Marinho (Funcionalidades e Priorização), Franck Patrick Hora Vasconcelos (Requisitos funcionais e consolidação), Murilo Pedral Mota (Requisitos não funcionais), Rafael Menezes Gonçalves (CRUD) |
| Data | 14/09/2026 |

Este documento transforma em funcionalidades e requisitos o que já foi levantado nas atividades anteriores: o problema e as restrições descritos no estudo de caso (`docs/estudo-de-caso.md`), os dados da pesquisa (`docs/pesquisa.md`), as personas Marina Souza e Lucas Andrade (`docs/personas.md`) e as lacunas identificadas no benchmark (`docs/benchmark.md`). Nenhuma funcionalidade aqui é nova em relação ao que já havia sido definido; o trabalho desta atividade é detalhar, numerar e priorizar o que antes estava descrito em prosa.

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
| RF16 | Funcionamento offline do diário | O sistema deve permitir a criação e a consulta de registros do diário de humor mesmo sem conexão à internet, sincronizando os dados quando a conexão for restabelecida. |
