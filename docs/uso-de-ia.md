# Projeto Unidade II: Registro de Uso de IA

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 b) vi)

| Campo | Preenchimento |
|---|---|
| Seção | Registro de Uso de IA (Q1 b) vi) |
| Responsável por esta entrada | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 3 (10/11/2026 a 17/11/2026) |
| Atividade registrada | Análise da documentação de `docs/` e correção das inconsistências (10/11/2026) |

## 1. Revisão da documentação (10/11/2026)

A documentação da Unidade II foi analisada em relação ao enunciado do Projeto II e à Atividade 05 da Unidade I, buscando links quebrados, inconsistências entre documentos, problemas de formatação e regras de negócio ainda não registradas. As correções foram aplicadas depois da revisão e da aprovação de Franck Patrick Hora Vasconcelos. A autoria original de cada documento está registrada no README, na seção "Revisão e correção da documentação".

### 1.1 Inconsistências encontradas e correções

| # | Documento | Inconsistência encontrada | Correção aplicada |
|---|---|---|---|
| 1 | `docs/escopo.md` | Formatação corrompida: tabelas sem `\|`, caminhos sem `/` (`docsrequisitos.md`) e datas sem barras (`10112026`). | Tabelas, caminhos e datas restaurados, sem alterar o conteúdo. |
| 2 | `docs/modelagem_firestore.md` | Mesma corrupção de formatação; diagrama, JSON e regras sem blocos de código. | Formatação e blocos de código restaurados; arquivo renomeado para `docs/modelagem-firestore.md`. |
| 3 | `docs/modelagem_firestore.md`, seção 7 | Security Rules inválidas: `match` sem barras, `allow ... if` sem dois-pontos, `\|\|` ausente e `<=`/`>=` virando `=`. | Sintaxe das regras corrigida. |
| 4 | `docs/mapeamento_dart_firestore.md` | Blocos de código sem marcação (palavra "dart" solta) e `List<int>` fora de código, que o GitHub esconde. | Blocos restaurados, `List<int>` entre crases; arquivo renomeado para `docs/mapeamento-dart-firestore.md`. |
| 5 | `docs/Diagrama de Classes.md` | Linha solta no topo, diagrama sem bloco de código e com sintaxe de Mermaid (`Future~Usuario~$`) apresentada como PlantUML. | Linha removida, código convertido para PlantUML válido, PDF renderizado novamente; arquivo renomeado para `docs/diagrama-classes.md`. |
| 6 | README, `docs/sprints.md`, `docs/mapeamento_dart_firestore.md` | Links para `diagrama-classes.md`, `modelagem-firestore.md` e `mapeamento-dart-firestore.md`, que não existiam com esses nomes. | Arquivos renomeados para os nomes já usados nos links; `mapeamento-firestore.pdf` renomeado para `mapeamento-dart-firestore.pdf`. |
| 7 | `docs/sprints.md`, `docs/eap.md`, README | Referência a um documento de "arquitetura" que não existe. | Referência apontada para a seção 8 de `docs/justificativas.md` (Arquitetura do sistema). |
| 8 | `docs/requisitos.md` | RF17 (autenticação) citado em vários documentos, mas inexistente em requisitos. | RF17 criado. |
| 9 | `docs/requisitos.md` | RF16 posicionado dentro da tabela de CRUD. | RF16 movido para a tabela de requisitos funcionais. |
| 10 | `docs/requisitos.md`, RNF06 | "Armazenados localmente por padrão, nuvem opcional", em conflito com o Firestore como banco do app. | RNF06 reescrito: Cloud Firestore com persistência offline. |
| 11 | `docs/justificativas.md`, seção 8 | Hive e SQLite citados como armazenamento; "nuvem sempre opcional"; "não exigem usuário autenticado". | Seção atualizada para Firebase Authentication e Cloud Firestore com persistência offline. |
| 12 | `docs/requisitos.md`, F04 e RF09 | "Disca diretamente com um único toque", em conflito com a tela de confirmação de chamada (Tela 07) e o UC09. | F04 e RF09 passam a descrever o toque que abre a confirmação antes da discagem (RN09). |
| 13 | `docs/justificativas.md`, seção 6 | "Não há tela intermediária" para o CVV, em conflito com a confirmação. | Texto ajustado: nenhuma tela até o botão, e o toque abre a confirmação. |
| 14 | `docs/estudo-de-caso.md` × `docs/requisitos.md`, RF05 | Animação "de 4 a 7 segundos por etapa" × padrão 4-7-8 (4s, 7s e 8s). | Nota indicando que prevalece o padrão 4-7-8 do RF05 (RN13). |
| 15 | `docs/estudo-de-caso.md` × `docs/escopo.md` | Estudo de caso limita a "até 4 telas principais"; o escopo lista 9 telas. | Escopo passa a definir 4 telas principais e as demais como secundárias (RN12). |
| 16 | `docs/modelagem_firestore.md`, seção 9 × RF12 | Humor e escore sem cifra no banco, enquanto o RF12 pedia criptografia dos dados do diário e do PHQ-9. | Decisão registrada: humor e escore sem cifra para histórico e gráfico; RF12 ajustado (RN10). |
| 17 | `docs/diagrama-classes.md` × `docs/mapeamento_dart_firestore.md` | Atributos privados no diagrama e públicos no código Dart de referência. | Código de referência com atributos privados (`_campo`) e getters. |
| 18 | `docs/mapeamento_dart_firestore.md`, seção 4 | Código de referência podia ser lido como código já implementado. | Indicado que é referência e que a implementação começa na Sprint 4. |
| 19 | `docs/escopo.md`, `docs/eap.md`, `docs/sprints.md` | Tela de login descrita sem campos de e-mail e senha e com protótipo previsto. | Cadastro opcional com e-mail e senha (F11, RF18 a RF20, UC15 a UC18); telas de conta fora do escopo de prototipação (RN11). |
| 20 | `docs/requisitos.md` × decisão do grupo | Autenticação só anônima, sem forma de manter o histórico ao reinstalar o app. | Uso anônimo mantido; cadastro opcional vincula a conta anônima e preserva os dados (RN19). |
| 21 | Vários documentos | Regras do "aditivo" citadas, mas sem aditivo oficial no repositório. | Regras consolidadas em `docs/regras-de-negocio.md` (RN01 a RN21), sem aditivo oficial. |
| 22 | `docs/regras-de-negocio.md` | Falha de conexão, tamanho da nota e repetição do PHQ-9 sem regra definida. | Definidas RN15 (sem bloqueio offline), RN16 (nota até 10.000 caracteres) e RN17 (PHQ-9 a cada 7 dias, gráfico sempre acessível). |
| 23 | `docs/sprints.md` | Rótulos em itálico, diferente do padrão dos outros documentos. | Rótulos em negrito. |
| 24 | README e CHANGELOG | EAP descrita como diagrama "em Mermaid", mas o código é PlantUML. | README corrigido; correção registrada no CHANGELOG sem reescrever a entrada antiga. |

### 1.2 Decisões tomadas pelo grupo durante a revisão

| Tema | Decisão |
|---|---|
| Documentos de referência | Enunciado do Projeto II e Atividade 05 (Unidade I). |
| Documentos de arquitetura e decisões visuais | Não são exigidos como arquivos próprios; o conteúdo está em `docs/justificativas.md`. |
| Nomes de arquivos | Padrão em minúsculas com hífen, igual aos links do README. |
| Banco de dados | Cloud Firestore com persistência offline, no lugar de Hive ou SQLite. |
| Autenticação | Uso sem cadastro (conta anônima) ou cadastro opcional com e-mail e senha, com recuperação de senha. |
| Telas de conta | Login, cadastro, recuperação de senha e perfil existem no app, sem protótipo. |
| Fluxo de entrada (ajuste de 17/11/2026) | Primeiro acesso pelo onboarding e depois a Tela 01 Início, sem cadastro; login e cadastro opcionais pelo ícone de conta da Início, como no código entregue na Sprint 3 (RN18). |
| Perfil | Nome de usuário e foto opcionais, só para cadastrados e não compartilhados. |
| CVV | Um toque abre a confirmação; a discagem só acontece depois de confirmar. |
| Respiração | Padrão 4-7-8 do RF05. |
| Telas principais | Diário, Respiração, PHQ-9 e CVV; as demais são secundárias. |
| Criptografia | Nota e respostas cifradas; humor e escore sem cifra, protegidos pelas Security Rules. |
| Diagrama de classes | Atributos privados; diagrama em PlantUML. |
| Créditos | Correções em documentos de outros integrantes registradas no README e no CHANGELOG, com a autoria original preservada. |

## 2. Sprint 4: AppBar padrão com SOS e Tela 07 CVV (18/11/2026)

| Campo | Preenchimento |
|---|---|
| Responsável por esta entrada | Rene Mendonça Marinho |
| Sprint | Sprint 4 (17/11/2026 a 23/11/2026) |
| Atividade registrada | Tarefas R1 (AppBar padrão com SOS, ajuste A5) e R2 (Tela 07 Confirmação de chamada ao CVV) |
| Ferramenta | Claude, com acesso à pasta do repositório |

### 2.1 Prompts que funcionaram

- O bloco "Contexto fixo do projeto Respira" no início de cada pedido (seção 3 do guia da Sprint 4). Ele evitou que a IA usasse o Firebase direto nas telas, criasse componentes repetidos ou fugisse dos tamanhos mínimos de toque e de texto.
- Os prompts das tarefas R1 e R2 com a API da AppBar já combinada com Murilo e Rafael (`RespiraAppBar(titulo:, mostrarVoltar:, transparente:)`) e os textos exatos da Tela 07. Com os textos prontos, a tela saiu igual ao protótipo sem precisar de várias rodadas.
- Pedir que a IA lesse antes o código existente (`SosCvvButton`, `DangerButton`, Telas 04 e 09 e os testes de Franck), e não só a descrição da tarefa.

### 2.2 Problemas encontrados e como foram resolvidos

| # | Problema | Como foi resolvido |
|---|---|---|
| 1 | O guia pede o "188" e os títulos em Poppins, mas o app ainda usa Libre Baskerville; a troca da tipografia é o ajuste A4, de Murilo. | Os textos usam a fonte do tema (`AppTheme`), só com o peso e o tamanho do protótipo. Quando Murilo trocar a fonte no tema, a Tela 07 e a AppBar mudam junto. |
| 2 | Se a Tela 07 usasse a AppBar padrão com SOS, o SOS abriria outra Tela 07 por cima dela. O protótipo também não mostra o SOS nessa tela. | Parâmetro opcional `mostrarSos` na `RespiraAppBar`, usado com `false` só na Tela 07. |
| 3 | A Início precisa do ícone de conta ao lado do SOS, e a API combinada não tinha onde colocar ícones extras. | Parâmetro opcional `acoes`, mostrado antes do SOS. A API combinada não mudou. |
| 4 | O `DangerButton` não aceitava ícone, e o protótipo mostra um telefone em "Ligar agora". | Parâmetro opcional `icone` no `DangerButton`, sem mudar o "Apagar tudo" da Tela 09. |
| 5 | O diagrama de classes define `ligar()` como `Future<void>`, mas a tela precisa saber se o discador abriu para orientar o usuário no navegador. | `ligar()` devolve `Future<bool>`, como no guia; o diagrama deve ser atualizado. |
| 6 | O teste de Franck "sem a Tela 07, o SOS avisa que está em breve" passaria a falhar, porque a Tela 07 agora existe. | O teste foi trocado por "o SOS abre a confirmação do CVV". Como a respiração anima sem parar, o teste avança só o tempo da transição em vez de usar `pumpAndSettle`. |
| 7 | O guia pede só a ação DIAL no AndroidManifest, mas o url_launcher abre o `tel:` com a ação VIEW. | As duas ações foram declaradas em `<queries>`. |
| 8 | A IA não consegue rodar o Flutter no computador do grupo. | Rene roda `flutter analyze` e `flutter test` com um script local (fora do Git) e repassa a saída para a IA corrigir o que falhar. |
| 9 | Erro da IA: o aviso "Ligue 188 pelo telefone do aparelho." usava `const Semantics(...)`, mas o construtor de `Semantics` não é `const` no Flutter 3.50. O `flutter analyze` acusou `const_with_non_const`, e os testes que importam a Tela 07 nem compilaram. | O `const` saiu do `Semantics` e ficou só no `Text`. |
| 10 | No Flutter 3.50, `package:flutter/material.dart` aparece como obsoleto (`deprecated_member_use`, aviso do tipo info) em todos os arquivos do projeto, não só nos novos. | Nada mudou nesta tarefa, porque o contexto fixo do guia manda usar esse import. A troca para `package:material_ui` fica para o grupo decidir. |

### 2.3 Escolha das bibliotecas

- **url_launcher** (Tela 07): pacote oficial da equipe do Flutter, que abre o discador com o número já digitado no Android, no iOS e no navegador. Não precisa da permissão `CALL_PHONE`, porque quem inicia a chamada é o usuário no próprio discador, o que mantém a confirmação da RN09. Funciona sem internet, já que o número está no código (RN08). Pacotes que ligam direto, como o flutter_phone_direct_caller, foram descartados por pularem essa confirmação e exigirem uma permissão sensível.
- **fl_chart** (Tela 06, tarefa R3): gráfico de linha feito só em Dart, sem código nativo, que funciona sem internet e aceita traço em gradiente e pontos personalizados, como no protótipo. Alternativas descartadas: o charts_flutter, que foi descontinuado, e o Syncfusion, que exige licença.
