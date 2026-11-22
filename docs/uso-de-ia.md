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
| Versão do Flutter (21/11/2026, P1) | Todos usam o Flutter 3.50.0, e o `pubspec.lock` é regenerado uma vez e versionado. |
| Telas já implementadas (21/11/2026, P2) | As Telas 01, 04 e 09 ficam como estão; as diferenças do protótipo são decisão do grupo (RN25). |
| Faixas do PHQ-9 (21/11/2026, P3) | Faixas padrão do instrumento (RN22). |
| Apoio na pergunta 9 do PHQ-9 (21/11/2026, P4) | Cartão de apoio com acesso ao CVV quando a resposta for maior que zero (RN23). |
| Troca de conta (21/11/2026, P5) | Aviso com confirmação antes de entrar numa conta existente quando há registros sem cadastro (RN24). |
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

## 3. Sprint 4 (Murilo Pedral Mota, 21/11/2026)

### 3.1 Pedidos que funcionaram

- Conferir os critérios por tarefa na seção 6.4 de `docs/sprints.md` e comparar as três telas com as páginas 2, 3 e 8 do protótipo de alta fidelidade.
- Reaproveitar `DependenciasScope`, os repositórios e componentes existentes no diário e ligar as configurações a `PerfilPage.abrir` e `LembretesService`.
- Conferir cada método da classe `Criptografia` com a implementação e renderizar o PlantUML para verificar a assinatura estática no PDF.

### 3.2 Erros e correções

| Situação | Correção |
| --- | --- |
| Um estilo explícito no título da barra removia a cor de primeiro plano aplicada pelo Flutter. | A barra usa o estilo de título do tema, com Poppins e a cor definida pelo Flutter ou pela própria tela. |
| Após o merge, o `pubspec.lock` trazia linhas soltas de uma segunda versão de `test_api`, e o teste de conta construía as dependências sem o serviço de lembretes. | O lock foi corrigido e resolvido com o Flutter 3.50.0. O teste de Rafael passou a receber o serviço em memória. |
| A barra compartilhada de Rene (N01) ainda estava ausente da base integrada. | As três telas usam a barra do Flutter para navegação de retorno. O botão SOS será integrado pelo contrato de N01. |

### 3.3 Fontes no app

Poppins (títulos) e Inter (textos) são distribuídas em `assets/fonts/`, com as licenças OFL. O Flutter pode carregá-las na primeira abertura sem baixar arquivos ou depender do cache da rede. `AppTheme.fontFamily` aponta para Inter, e os estilos de título usam Poppins.

### 3.4 Verificações

- Flutter 3.50.0 com `flutter pub get --enforce-lockfile`, `flutter analyze --no-fatal-infos` e `flutter test`. Os 64 testes passaram. A análise apontou apenas as informações sobre a descontinuação de `package:flutter/material.dart`, já aceita pelo grupo.
- As Telas 02, 03 e 08 foram comparadas com o protótipo e verificadas a 360 px. O PDF do diagrama foi renderizado com PlantUML e conferido com os cinco métodos de `Criptografia`. `gerarChave()` está sublinhado.
- V03 passou no Chrome com o Firebase Respira em `localhost:5050`. Uma sessão anônima de teste gravou uma nota sintética. Uma leitura direta do servidor Firestore confirmou `notaCifrada` sem o texto original. Após recarregar a página, a mesma sessão exibiu a nota no histórico. A exclusão pelo app foi confirmada no servidor.
- A validação dos lembretes no celular e dos fluxos em modo avião continua para a Sprint 5.

## 4. Sprint 4: barra superior com SOS e Tela 07 CVV (Rene Mendonça Marinho, 22/11/2026)

### 4.1 Pedidos que funcionaram

- Colar o guia completo da sprint (papel, contexto vigente, limites e steps) como primeira mensagem. Com os contratos do grupo escritos ali, a IA usou a assinatura exata da `RespiraAppBar` e não criou componentes paralelos.
- Pedir que a IA perguntasse antes de decidir o que o guia não resolvia. Foram três perguntas, respondidas por Rene: manter a assinatura exata da `RespiraAppBar`, criar uma branch nova a partir da `main` atualizada e dividir o trabalho em dois pull requests (N01 e N02 primeiro; N03 e N07 depois do merge de Murilo na Início).
- Pedir que a IA lesse o código existente (`SosCvvButton`, `DangerButton`, Telas 04 e 09 e os testes) antes de escrever.

### 4.2 Erros encontrados e como foram corrigidos

| Situação | Correção |
| --- | --- |
| A primeira versão (branch `rene-sprint4`, de 18/11) foi feita sobre a `main` antiga e tinha parâmetros que o contrato de 21/11 não prevê (`acoes`, `onSos` e `mostrarSos`). | Refeita na branch `rene-sprint4-v2`, a partir da `main` atualizada, com a assinatura exata: `acoes` virou `acoesExtras`, e `onSos` e `mostrarSos` saíram. A Tela 07 usa uma barra simples, sem SOS, para o SOS não abrir a própria tela. |
| Erro da IA: o aviso "Ligue 188 pelo telefone do aparelho." usava `const Semantics(...)`, mas o construtor de `Semantics` não é `const` no Flutter 3.50.0. O `flutter analyze` acusou `const_with_non_const` e os testes que importam a Tela 07 não compilaram. | O `const` saiu do `Semantics` e ficou só no `Text`. |
| No primeiro commit, o README apareceu com o arquivo inteiro alterado, embora só duas linhas tivessem mudado: a IA gravou o arquivo com final de linha CRLF, e o repositório usa LF. | Na branch nova, os arquivos são gravados com LF, como no repositório. |
| O guia pede só a ação DIAL no `AndroidManifest.xml`, mas o `url_launcher` abre o `tel:` com a ação VIEW. | As duas ações foram declaradas em `<queries>`. |
| A IA não consegue rodar o Flutter na máquina de Rene. | Rene roda `flutter analyze` e `flutter test` com um script local (fora do Git) e repassa a saída para a IA corrigir o que falhar. |

### 4.3 Justificativa de `url_launcher` e `fl_chart`

- **`url_launcher`** (Tela 07): pacote oficial da equipe do Flutter, que abre o discador com o número já digitado no Android, no iOS e no navegador. Não precisa da permissão `CALL_PHONE`, porque quem inicia a chamada é o usuário no próprio discador. Isso mantém a confirmação da RN09 e funciona sem internet, já que o número está no código (RN08). Pacotes que ligam direto, como o `flutter_phone_direct_caller`, foram descartados porque pulam essa confirmação e exigem uma permissão sensível.
- **`fl_chart`** (Tela 06, N07): gráfico de linha feito só em Dart, sem código nativo, que funciona sem internet e aceita traço em gradiente e pontos personalizados, como no protótipo. Foram descartados o `charts_flutter`, que foi descontinuado, e o Syncfusion, que exige licença. Entra no segundo pull request, com as Telas 05 e 06.

### 4.4 Segundo pull request: SOS nas telas e PHQ-9 (N03 e N07)

- **Pedidos que funcionaram:**
  - Dar à IA os textos exatos das Telas 05 e 06, as faixas da RN22 e o cartão da RN23. Assim nada precisou ser inventado.
  - Pedir que a IA conferisse a assinatura do `fl_chart` no código-fonte da versão atual (1.3.1) antes de escrever o gráfico.
- **Decisões tomadas sem pergunta, por seguirem o guia:**
  - O `onSos` das Telas 04 e 09 ficou sem uso, como Rene escolheu ao manter a assinatura exata da `RespiraAppBar`.
  - Na Tela 05, a seta de voltar usa um `PopScope`, para voltar à pergunta anterior em vez de sair do questionário.
  - O número do escore e o selo da faixa têm chaves (`phq9-escore` e `phq9-faixa`) nos testes, porque o "9" também aparece no eixo do gráfico.
- **Erros da IA, corrigidos depois do primeiro `flutter test`:**
  - A barra de progresso da Tela 05 recebeu um `semanticsValue` em texto ("Pergunta 1 de 9"). O Flutter só aceita número nesse campo e acusou erro nos testes da tela. O texto saiu desse campo, e o "Pergunta X de 9" continua visível na tela.
  - O teste do card PHQ-9 da Início tentava tocar num card fora da área visível da tela de teste. Na primeira correção, a IA estreitou a tela para 412 px, e os cards da Início (que não são desta tarefa) estouraram com a fonte de teste. O teste passou a usar a largura padrão (800 px) com uma altura maior.
- **Não verificado:** a V04 (PHQ-9 no Firebase real) e a discagem num Android dependem do app rodando no navegador ou num aparelho. Não são declaradas como feitas com base nos testes em memória.
