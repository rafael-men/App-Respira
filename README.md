# App Respira

Aplicativo de saúde mental e apoio emocional, com diário de humor, respiração guiada (padrão 4-7-8), rastreio por questionário (PHQ-9) e acesso rápido ao CVV (188) em situações de crise.

## Turma

Programação para Dispositivos Móveis, GP0029VNO07A

## Integrantes

| Integrante | Responsabilidade na Atividade 01 |
|---|---|
| Franck Patrick Hora Vasconcelos | Análise do problema (seção 1) e consolidação do documento |
| Murilo Pedral Mota | Estrutura do repositório (README, CHANGELOG), Análise de público e usuários (seção 2) e contexto de uso (seção 3) |
| Rafael Menezes Gonçalves | Análise de objetivo/proposta de valor (seção 4) e personalidade/identidade/experiência (seção 5) |
| Rene Mendonça Marinho | Análise de funcionalidades (seção 6), restrições e condições (seção 7) e pontos de atenção (seção 8) |

## Atividade 02: Pesquisa, Benchmark e Personas

| Integrante | Responsabilidade na Atividade 02 |
|---|---|
| Franck Patrick Hora Vasconcelos | Benchmark de soluções existentes (docs/benchmark.md) |
| Murilo Pedral Mota | Pesquisa do projeto (docs/pesquisa.md) e criação do slide da apresentação |
| Rafael Menezes Gonçalves | Persona 1 (docs/personas.md) |
| Rene Mendonça Marinho | Persona 2 (docs/personas.md) |

# Atividade 03: Funcionalidades e Requisitos

| Integrante | Responsabilidade na Atividade 03 |
|---|---|
| Franck Patrick Hora Vasconcelos | Requisitos funcionais e consolidação |
| Murilo Pedral Mota | Requisitos não funcionais, Priorização e Apresentação de Requisitos |
| Rafael Menezes Gonçalves | CRUD |
| Rene Mendonça Marinho | Funcionalidades e Priorização |

# Atividade 04: Prototipação 1/3 (Protótipo de Baixa Fidelidade)

| Tela | Nome | Responsável |
|---|---|---|
| 01 | Início | Murilo Pedral Mota |
| 02 | Diário de Humor — Registro | Murilo Pedral Mota |
| 03 | Diário de Humor — Histórico | Murilo Pedral Mota |
| 04 | Respiração Guiada (4-7-8) | Franck Patrick Hora Vasconcelos |
| 05 | Questionário PHQ-9 — Pergunta | Franck Patrick Hora Vasconcelos |
| 06 | Questionário PHQ-9 — Resultado | Rene Mendonça Marinho |
| 07 | Confirmação de Chamada ao CVV | Rene Mendonça Marinho |
| 08 | Configurações | Rafael Menezes Gonçalves |
| 09 | Confirmação do Botão de Pânico | Rafael Menezes Gonçalves |

| Atividade | Responsável |
| --- | --- |
| Adicionar docs/prototipoBaixaFidelidade.pdf com link e todas as telas | Murilo Pedral Mota |

Esta etapa cobre apenas o protótipo de baixa fidelidade (estrutura e fluxo das telas, sem cor, tipografia ou identidade visual definitivas). O protótipo de alta fidelidade e as justificativas de UI/UX pertencem a etapas futuras da Atividade 04.

# Atividade 04: Prototipação 3/3 (Protótipo de Alta Fidelidade e Justificativas)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/prototipoAltaFidelidade.pdf`](docs/prototipoAltaFidelidade.pdf), com o protótipo de alta fidelidade em PDF | Murilo Pedral Mota |
| Seções 1, 2 e 3 de [`docs/justificativas.md`](docs/justificativas.md) | Murilo Pedral Mota |
| Seções 4 e 5 de [`docs/justificativas.md`](docs/justificativas.md) | Rafael Menezes Gonçalves |
| Seções 6 e 7 de [`docs/justificativas.md`](docs/justificativas.md) | Franck Patrick Hora Vasconcelos |
| Seções 8 e 9 de [`docs/justificativas.md`](docs/justificativas.md) | Rene Mendonça Marinho |

# Atividade 05: Apresentação Final da Unidade I

| Atividade | Responsável |
| --- | --- |
| Anexar o documento de apresentação final da Unidade I em [`docs/apresentacaoFinalUnidadeI.pdf`](docs/apresentacaoFinalUnidadeI.pdf) | Murilo Pedral Mota |
| Slides 1 a 8 da apresentação final da Unidade I | Franck Patrick Hora Vasconcelos |
| Slides 9 a 12 da apresentação final da Unidade I | Murilo Pedral Mota |
| Slides 13 a 16 da apresentação final da Unidade I | Rafael Menezes Gonçalves |
| Slides 17 a 22 da apresentação final da Unidade I | Rene Mendonça Marinho |

# Unidade II: Projeto (Programação para Dispositivos Móveis)

Stack obrigatória: Dart, Flutter e Firebase (Autenticação e Banco de Dados). Apresentações em 24/11/2026 e 01/12/2026.

## Sprint 1 (03/11/2026 a 09/11/2026)

### Tópico 01: Q1 a) ii) Firebase (Autenticação e Banco de Dados)

Decisão: Firebase Authentication anônimo e Cloud Firestore com persistência offline, mantendo o uso sem cadastro (RF11) e o funcionamento offline (RF16).

| Integrante | Responsabilidade no Tópico 01 | Status |
|---|---|---|
| Franck Patrick Hora Vasconcelos | Endosso do Firebase em estudo-de-caso (seção 1), benchmark, RF11, RF12, RF13 e novo RF17 em requisitos, seção 7 de justificativas e README | Pendente |
| Murilo Pedral Mota | Endosso em estudo-de-caso (seção 3), pesquisa (3.2, 3.4 e síntese), RNF03, RNF06 e RNF07 em requisitos, serviços de nuvem (Firebase) na seção 8 de justificativas (Arquitetura do sistema) | Pendente |
| Rafael Menezes Gonçalves | Endosso na persona 1, mapeamento do CRUD para coleções do Firestore e reposicionamento do RF16 em requisitos, seção 4 de justificativas | Pendente |
| Rene Mendonça Marinho | Endosso em estudo-de-caso (seções 6, 7 e 8.1), persona 2, F05 a F08 em requisitos, seção 8 de justificativas | Pendente |

## Descrição do projeto

Dart, Flutter e Firebase (Authentication anônimo e Cloud Firestore com persistência offline).

O Respira é um espaço digital seguro para cuidado emocional, voltado a adultos em geral, universitários, professores e pacientes de CAPS. Reúne três frentes que normalmente aparecem separadas: alívio imediato (respiração guiada), autoconhecimento (diário de humor e PHQ-9 semanal) e acesso rápido à rede de apoio (CVV). O projeto prioriza privacidade, uso anônimo, funcionamento offline e uma interface que induz calma em vez de competir por atenção.

## Documentação

A análise completa do estudo de caso está em [`docs/estudo-de-caso.md`](docs/estudo-de-caso.md).

O benchmark de soluções existentes está em [`docs/benchmark.md`](docs/benchmark.md).

# Projeto Unidade II: Escopo do Projeto (Questão 01 d) i)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/escopo.md`](docs/escopo.md), com o escopo do projeto (objetivo, justificativa, público, escopo do produto e técnico, entregáveis, fora do escopo, premissas, restrições e critérios de aceitação) | Murilo Pedral Mota |

# Projeto Unidade II: Diagrama de Casos de Uso (Questão 01 b) i)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/diagrama-casos-de-uso.md`](docs/diagrama-casos-de-uso.md) e [`docs/diagrama-casos-de-uso.pdf`](docs/diagrama-casos-de-uso.pdf), com atores, casos de uso UC01 a UC14, regras de negócio RN01 a RN08 e código PlantUML | Franck Patrick Hora Vasconcelos |

O diagrama de casos de uso da Unidade II está em [`docs/diagrama-casos-de-uso.md`](docs/diagrama-casos-de-uso.md).

# Projeto Unidade II: Estrutura Analítica do Projeto, EAP (Questão 01 d) ii)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/eap.md`](docs/eap.md), com a EAP simplificada: diagrama em PlantUML com 7 pacotes principais e dicionário com entregável e origem de cada pacote | Franck Patrick Hora Vasconcelos |

A EAP do projeto da Unidade II está em [`docs/eap.md`](docs/eap.md).

# Projeto Unidade II: Diagrama de Classes (Questão 01 b) ii)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/diagrama-classes.md`](docs/diagrama-classes.md) e [`docs/diagrama-classes.pdf`](docs/diagrama-classes.pdf), com as classes de domínio, atributos, métodos, relacionamentos e descrição de cada classe | Murilo Pedral Mota |

O diagrama de classes da Unidade II está em [`docs/diagrama-classes.md`](docs/diagrama-classes.md).

# Projeto Unidade II: Modelagem do Banco de Dados no Firestore (Questão 01 b) iii)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/modelagem-firestore.md`](docs/modelagem-firestore.md), com coleções, documentos, campos, consultas, Security Rules e exclusão pelo Botão de Pânico | Rafael Menezes Gonçalves |

A modelagem do banco de dados no Firestore está em [`docs/modelagem-firestore.md`](docs/modelagem-firestore.md).

# Projeto Unidade II: Mapeamento das Classes Dart para o Firestore (Questão 01 b) iv)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/mapeamento-dart-firestore.md`](docs/mapeamento-dart-firestore.md), com a correspondência campo a campo entre as classes e os documentos, regras de conversão de tipos, `toMap()`/`fromMap()` e uso de `withConverter` | Rene Mendonça Marinho |

O mapeamento das classes Dart para o Firestore está em [`docs/mapeamento-dart-firestore.md`](docs/mapeamento-dart-firestore.md).

# Projeto Unidade II: Planejamento do Desenvolvimento em Sprints (Questão 01 d) iii)

| Atividade | Responsável |
| --- | --- |
| Adicionar as seções 1 a 4 de [`docs/sprints.md`](docs/sprints.md): premissas, calendário, Sprint 1 e Sprint 2 | Rene Mendonça Marinho |
| Adicionar as seções 5 a 8 de [`docs/sprints.md`](docs/sprints.md): Sprint 3, Sprint 4, riscos e ritual dos checkpoints | Rafael Menezes Gonçalves |

O planejamento em sprints da Unidade II está em [`docs/sprints.md`](docs/sprints.md).

# Projeto Unidade II: Regras de Negócio (Questão 01 a) iv e b) i)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/regras-de-negocio.md`](docs/regras-de-negocio.md), com as regras de negócio consolidadas (RN01 a RN21): conta e privacidade, diário, PHQ-9, respiração, emergência, falhas de conexão e exclusão | Franck Patrick Hora Vasconcelos |

# Projeto Unidade II: Registro de Uso de IA (Questão 01 b) vi)

| Atividade | Responsável |
| --- | --- |
| Adicionar [`docs/uso-de-ia.md`](docs/uso-de-ia.md), com a tabela de inconsistências encontradas na revisão da documentação, as correções aplicadas e as decisões do grupo | Franck Patrick Hora Vasconcelos |

# Projeto Unidade II: Revisão e correção da documentação

Franck Patrick Hora Vasconcelos revisou a documentação da Unidade II e fez correções em documentos de outros integrantes, para manter os documentos coerentes entre si. **As correções não substituem a autoria original:** o conteúdo de cada documento continua sendo do integrante indicado na coluna "Autoria original", e os commits originais de cada um continuam valendo como evidência da sua participação. Os commits dessas correções saem da conta de Franck porque foi ele quem as fez.

| Documento | Autoria original | Correções feitas por Franck Patrick Hora Vasconcelos |
| --- | --- | --- |
| [`docs/escopo.md`](docs/escopo.md) | Murilo Pedral Mota | Formatação restaurada (tabelas, caminhos e datas que tinham perdido os caracteres `\|` e `/`); telas de conta e cadastro opcional (F11); quatro telas principais; aditivo; critérios de aceitação. |
| [`docs/diagrama-classes.md`](docs/diagrama-classes.md) e `.pdf` | Murilo Pedral Mota | Arquivo renomeado (antes `Diagrama de Classes.md`); código convertido de sintaxe Mermaid para PlantUML válido; métodos de conta e perfil na classe `Usuario`; PDF renderizado novamente. |
| [`docs/modelagem-firestore.md`](docs/modelagem-firestore.md) e `.pdf` | Rafael Menezes Gonçalves | Arquivo renomeado (antes `modelagem_firestore.md`); formatação restaurada; sintaxe das Security Rules corrigida; campos de perfil, cadastro e tamanho da nota; decisão sobre criptografia (seção 9); PDF renderizado novamente. |
| [`docs/mapeamento-dart-firestore.md`](docs/mapeamento-dart-firestore.md) e `.pdf` | Rene Mendonça Marinho | Arquivos renomeados (antes `mapeamento_dart_firestore.md` e `mapeamento-firestore.pdf`); blocos de código restaurados; atributos privados no código de referência; campos de conta e perfil; chamadas de cadastro, login e recuperação de senha. |
| [`docs/sprints.md`](docs/sprints.md) | Rene Mendonça Marinho (seções 1 a 4) e Rafael Menezes Gonçalves (seções 5 a 8) | Referência à "arquitetura" apontada para a seção 8 de justificativas; tarefas de conta e perfil; riscos do aditivo e do login; rótulos em negrito. |
| [`docs/requisitos.md`](docs/requisitos.md) | Rene, Franck, Murilo e Rafael (Atividade 03) | RF09 (confirmação antes de discar), RF02 (nota até 10.000 caracteres), RF12, RNF03, RNF06, RF16 reposicionado, novos F11 e RF17 a RF20, CRUD. |
| [`docs/justificativas.md`](docs/justificativas.md) | Murilo, Rafael, Franck e Rene (Atividade 04) | Seção 8 atualizada para Firebase (sem Hive ou SQLite) e para o cadastro opcional; texto do botão do CVV (seção 6). |
| [`docs/estudo-de-caso.md`](docs/estudo-de-caso.md) | Franck, Murilo, Rafael e Rene (Atividade 01) | Nota na restrição de animação: prevalece o padrão 4-7-8 do RF05. |
| [`docs/eap.md`](docs/eap.md) e `.pdf`, [`docs/diagrama-casos-de-uso.md`](docs/diagrama-casos-de-uso.md) e `.pdf` | Franck Patrick Hora Vasconcelos | Telas de conta, autenticação anônima e por e-mail e senha, casos de uso UC15 a UC18; PDFs renderizados novamente. |