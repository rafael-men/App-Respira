# Projeto Unidade II: Registro de Uso de IA

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 b) vi)

| Campo | Preenchimento |
| --- | --- |
| Seção | Registro de Uso de IA (Q1 b) vi) |
| Responsável por esta entrada | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 3 (10/11/2026 a 17/11/2026) |
| Atividade registrada | Análise da documentação de `docs/` e correção das inconsistências (10/11/2026) |

## 1. Revisão da documentação (10/11/2026)

A documentação da Unidade II foi analisada em relação ao enunciado do Projeto II e à Atividade 05 da Unidade I, buscando links quebrados, inconsistências entre documentos, problemas de formatação e regras de negócio ainda não registradas. As correções foram aplicadas depois da revisão e da aprovação de Franck Patrick Hora Vasconcelos. A autoria original de cada documento está registrada no README, na seção "Revisão e correção da documentação".

### 1.1 Inconsistências encontradas e correções

| # | Documento | Inconsistência encontrada | Correção aplicada |
| --- | --- | --- | --- |
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
| --- | --- |
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

## 2. Sprint 4: contas, perfil e aviso de troca de conta (Rafael Menezes Gonçalves, 21/11/2026)

### 2.1 Pedidos que funcionaram

- Pedir que a IA lesse antes de alterar: `auth_repository.dart`, `login_page.dart`, `home_page.dart` e `dependencias.dart` foram lidos antes de qualquer edição, para reaproveitar `AuthRepository`, `DependenciasScope` e os componentes de autenticação em vez de criar outros.
- Pedir uma tarefa por vez, com o critério de aceite junto (por exemplo, "e-mail inválido mostra erro e o envio mostra a mensagem genérica da RN21"). Os testes foram escritos a partir desses critérios.
- Pedir para parar quando uma dependência de outro integrante não estava na branch (a `RespiraAppBar` de Rene para o N04 e os contratos de Murilo para o N12). A IA registrou o bloqueio em vez de criar uma versão paralela.

### 2.2 Erros encontrados e como foram corrigidos

| Situação | Correção |
| --- | --- |
| A tarefa pedia Flutter 3.50.0, mas o ambiente tinha 3.44.9. | Mantido o Flutter instalado para o desenvolvimento e registrado no relatório. A versão do grupo precisa ser confirmada antes do merge. |
| `flutter pub add image_picker` alterou também versões de `matcher`, `meta`, `test_api` e outros pacotes no `pubspec.lock`. | O lock foi mantido como o pub gerou. A alteração precisa ser revisada no merge, porque ele muda pacotes que não são da tarefa. |
| Sem a chave de Firebase real e sem o aparelho, não dá para confirmar o envio de e-mail de recuperação, o cadastro com vínculo e a galeria. | Essas validações ficaram marcadas como "não verificadas" no relatório, sem declarar que funcionam. |

### 2.3 Justificativa de `image_picker`

A foto do perfil (RF20) é escolhida na galeria com `image_picker`, que é o plugin oficial do Flutter para Android, iOS e web. Os parâmetros `maxWidth: 256`, `maxHeight: 256` e `imageQuality: 70` reduzem a imagem antes de ela ser convertida para Base64 e gravada em `usuarios/{uid}`. Isso mantém o documento pequeno no Firestore, que tem limite de 1 MiB por documento. A permissão de galeria no iOS está descrita em `NSPhotoLibraryUsageDescription`.
