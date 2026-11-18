# Projeto Unidade II: Planejamento do Desenvolvimento em Sprints
 
Projeto Respira, aplicativo de saúde mental e apoio emocional
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 d) iii) (parte de 1,0 ponto)
 
| Campo | Preenchimento |
|---|---|
| Seção | Planejamento do desenvolvimento em sprints (Q1 d) iii) |
| Autores desta seção | Rene Mendonça Marinho (premissas, calendário, Sprints 1 e 2) e Rafael Menezes Gonçalves (sprints de implementação, riscos e ritual dos checkpoints) |
| Sprint | Sprint 2 (03/11/2026 a 10/11/2026); replanejado em 17/11/2026 |
| Base | Enunciado do Projeto II, docs/escopo.md, docs/eap.md, docs/requisitos.md e a divisão de telas da Atividade 04 no README |
 
O planejamento distribui os pacotes de trabalho de docs/eap.md em cinco sprints semanais, alinhadas aos checkpoints semanais exigidos pelo Projeto II (observação 1 e Q1 c) iii). Os códigos entre parênteses (ex.: 1.5.3) remetem à EAP.
 
## 1. Premissas do planejamento
 
- Sprints de uma semana, com checkpoint toda terça-feira, no dia da aula: o checkpoint fecha uma sprint e abre a seguinte.
- As apresentações acontecem em 24/11/2026 e 01/12/2026. Como o grupo pode apresentar já no dia 24/11, **o app precisa compilar e executar ao fim da Sprint 4 (23/11/2026)**. A Sprint 5 testa e estabiliza o app.
- A implementação de cada tela fica, sempre que possível, com o integrante que desenhou essa tela no protótipo de baixa fidelidade (README, Atividade 04), para aproveitar o conhecimento já adquirido e dar evidência de código a todos (Q1 c) i). Como Rafael já entregou as telas de onboarding, login, cadastro e Início, as telas restantes foram redistribuídas entre Franck, Murilo e Rene (seção 6).
- As duas últimas sprints concentram o código: a Sprint 4 implementa todas as telas e a Sprint 5 é dedicada a testes, validações e acabamento.
- Cada integrante registra no CHANGELOG o que fez e atualiza o status no README no mesmo commit da entrega (Q1 c) ii).
- Cada integrante registra em docs/uso-de-ia.md os prompts, erros e soluções da própria parte (Q1 b) vi).
 
## 2. Calendário
 
| Sprint | Período | Checkpoint de abertura | Objetivo |
|---|---|---|---|
| Sprint 1 | 27/10/2026 a 03/11/2026 | 27/10/2026 | Adaptar a documentação existente ao Firebase |
| Sprint 2 | 03/11/2026 a 10/11/2026 | 03/11/2026 | Planejamento e modelagem: escopo, EAP, sprints, casos de uso, classes e banco de dados |
| Sprint 3 | 10/11/2026 a 17/11/2026 | 10/11/2026 | Revisão da documentação e primeiras telas do app |
| Sprint 4 | 17/11/2026 a 23/11/2026 | 17/11/2026 | Implementação de todas as telas, com Firebase, compilando e executando |
| Sprint 5 | 24/11/2026 a 01/12/2026 | 24/11/2026 (1ª apresentação) | Testes, validações, correções, documentação final e apresentação |
| Entrega | 01/12/2026 | 01/12/2026 (2ª apresentação) | Defesa oral e link do repositório no Teams |
 
## 3. Sprint 1 (27/10/2026 a 03/11/2026): Firebase na documentação
 
**Objetivo:** endossar a decisão por Firebase Authentication anônimo e Cloud Firestore com persistência offline em todos os documentos existentes (1.2.1).
 
| Integrante | Tarefas | Pacote EAP |
|---|---|---|
| Franck Patrick Hora Vasconcelos | Endosso em estudo de caso (seção 1), benchmark, RF11, RF12, RF13 e novo RF17 em requisitos, seção 7 de justificativas e README | 1.2.1 |
| Murilo Pedral Mota | Endosso em estudo de caso (seção 3), pesquisa (3.2, 3.4 e síntese), RNF03, RNF06 e RNF07, serviços de nuvem (Firebase) na seção 8 de justificativas (Arquitetura do sistema) | 1.2.1 |
| Rafael Menezes Gonçalves | Endosso na persona 1, CRUD ligado às coleções do Firestore e reposicionamento do RF16, seção 4 de justificativas | 1.2.1 |
| Rene Mendonça Marinho | Endosso em estudo de caso (seções 6, 7 e 8.1), persona 2, F05 a F08, seção 8 de justificativas | 1.2.1 |
 
**Pronto quando:** nenhum documento afirma "não existe conta" sem qualificar como conta anônima, e nenhum cita Hive ou SQLite como armazenamento principal.
 
## 4. Sprint 2 (03/11/2026 a 10/11/2026): planejamento e modelagem
 
**Objetivo:** fechar o planejamento (Q1 d) e a modelagem (Q1 b) i a iv) antes de escrever código.
 
| Integrante | Tarefas | Pacote EAP | Item do Projeto II |
|---|---|---|---|
| Murilo Pedral Mota | Escopo do projeto (docs/escopo.md); Diagrama de Classes (docs/diagrama-classes.md) | 1.1.1; 1.2.3 | Q1 d) i; Q1 b) ii |
| Franck Patrick Hora Vasconcelos | EAP simplificada (docs/eap.md); Diagrama de Casos de Uso (docs/diagrama-casos-de-uso.md) | 1.1.2; 1.2.2 | Q1 d) ii; Q1 b) i |
| Rene Mendonça Marinho | Planejamento em sprints, seções 1 a 4 (docs/sprints.md); mapeamento das classes Dart para o Firestore | 1.1.3; 1.2.5 | Q1 d) iii; Q1 b) iv |
| Rafael Menezes Gonçalves | Planejamento em sprints, seções 5 a 8 (docs/sprints.md); modelagem das coleções e documentos do Firestore | 1.1.3; 1.2.4 | Q1 d) iii; Q1 b) iii |
 
**Dependências internas:** o Diagrama de Classes (Murilo) é a entrada do mapeamento Dart → Firestore (Rene) e deve ficar pronto antes dele. A modelagem do Firestore (Rafael) e o mapeamento (Rene) precisam usar os mesmos nomes de coleção.
 
**Pronto quando:** os quatro diagramas e modelagens estão em docs/, com nomes de entidades e coleções coerentes entre si e com docs/requisitos.md.

## 5. Sprint 3 (10/11/2026 a 17/11/2026): revisão da documentação e primeiras telas

**Objetivo:** deixar a documentação coerente antes do código e começar o app pelas telas de entrada.

| Integrante | Entregas | Pacote EAP | Itens |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Revisão e correção da documentação de docs/ (formatação, links, Security Rules e inconsistências); regras de negócio consolidadas (docs/regras-de-negocio.md); cadastro opcional com e-mail e senha nos documentos (F11, RF17 a RF20, UC15 a UC18); registro em docs/uso-de-ia.md | 1.2.1 a 1.2.7 | Q1 a) iv; Q1 b) i a iv e vi |
| Rafael Menezes Gonçalves | Base do app em Flutter: tema e cores, botão em gradiente, onboarding, login, cadastro e Tela 01 Início (commit `67f627a`) | 1.5.1; 1.5.2; 1.5.11 | RF11, RF18; Q1 a) i e iii |

## 6. Sprint 4 (17/11/2026 a 23/11/2026): implementação de todas as telas

**Objetivo:** implementar todas as telas e funcionalidades (F01 a F11) ligadas ao Firebase, com o app compilando e executando no emulador e em um Android real até 23/11, pronto para a apresentação de 24/11.

### 6.1 Ponto de partida: código já entregue na Sprint 3

Rafael entregou, no commit `67f627a`, a base do app em `respira_main/lib`: tema e cores (`core/theme`), botão em gradiente, telas de onboarding, login, cadastro e Início (Tela 01), seletor de humor, cards de funcionalidade e botão SOS. O login e o cadastro usam a interface `AuthRepository` com uma implementação em memória (`LocalAuthRepository`), que será trocada pela implementação com Firebase sem mudar as telas.

A revisão desse código encontrou os ajustes abaixo, que entram na Sprint 4:

| # | Ajuste | Onde | Responsável |
|---|---|---|---|
| A1 | O aviso "Seus dados ficam salvos apenas neste aparelho. O app não usa internet." passa a ser falso com o Firebase; trocar por um texto sobre conta anônima e cadastro opcional. | `auth/widgets/auth_widgets.dart` | Rafael |
| A2 | Erro de digitação "quesrionário" no onboarding. | `main/pages/onboarding_page.dart` | Rafael |
| A3 | O onboarding aparece a cada abertura do app e as respostas ficam só em memória; deve aparecer só no primeiro acesso, com as respostas salvas no aparelho. | `onboarding_page.dart`, `preferencias_usuario.dart` | Rafael |
| A4 | A fonte usada é Libre Baskerville; o protótipo de alta fidelidade usa Poppins (títulos e botões) e Inter (corpo de texto), e a Q1 a) iii exige fidelidade ao protótipo. | `core/theme`, `pubspec.yaml` | Murilo |
| A5 | O botão SOS existe só na Início; o RF09 exige o botão em todas as telas. Criar uma AppBar padrão com o SOS e usá-la em todas as telas. | `core/widgets` | Rene |
| A6 | Login sem "Esqueci minha senha" (RF19) e Início sem forma de sair da conta. | `login_page.dart`, `home_page.dart` | Rene |
| A7 | `applicationId` ainda é `com.example.respira_main`; precisa ser definitivo antes de registrar o app no Firebase. | `android/app/build.gradle.kts`, iOS | Franck |
| A8 | A pasta `test/` foi removida e o `pubspec.yaml` ainda tem a descrição padrão "A new Flutter project". | `respira_main/` | Franck |
| A9 | O botão SOS também precisa aparecer no onboarding, no login e no cadastro (RN18). Depende da AppBar padrão de Rene (A5). | `onboarding_page.dart`, `login_page.dart`, `cadastro_page.dart` | Rafael |

Os ajustes A4 a A8 alteram arquivos de Rafael e serão registrados no README e no CHANGELOG com a autoria original preservada.

### 6.2 Entregas por integrante

| Integrante | Entregas | Pacote EAP | Requisitos |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Projeto Firebase e FlutterFire (`firebase_core`, `firebase_auth`, `cloud_firestore`); `FirebaseAuthRepository` (uso anônimo, cadastro com vinculação da conta anônima, login, recuperação de senha, saída e exclusão de conta); persistência offline; modelos e repositórios de dados (`Usuario`, `Configuracoes`, `RegistroHumor`, `RespostaPHQ9`) com `withConverter`; serviço `Criptografia`; publicação das Security Rules; **Tela 04 Respiração 4-7-8**; **Tela 09 Botão de Pânico**; ajustes A7 e A8 | 1.4.1 a 1.4.5; 1.5.4; 1.5.8 | RF05, RF11 a RF13, RF16 a RF19, RNF03, RNF04, RNF06 |
| Murilo Pedral Mota | Tipografia Poppins e Inter (A4); **Telas 02 e 03 Diário de humor** (registro com nota até 10.000 caracteres, histórico e exclusão), com o humor escolhido na Início levando direto à Tela 02; **Tela 08 Configurações** (tema e notificações gravados no Firestore); tema escuro; **perfil opcional** (nome de usuário e foto); lembretes não invasivos | 1.5.1; 1.5.3; 1.5.7; 1.5.9 a 1.5.11 | RF01 a RF04, RF14, RF15, RF20, RNF01 |
| Rene Mendonça Marinho | AppBar padrão com SOS em todas as telas (A5); **Tela 07 Confirmação de chamada ao CVV** (discagem do 188 com `url_launcher`, sem rede); **Telas 05 e 06 PHQ-9** (perguntas, escore, gráfico de evolução e intervalo de 7 dias); **tela de recuperação de senha** e opção de sair da conta (A6) | 1.5.5; 1.5.6; 1.5.11 | RF06 a RF10, RF19 |
| Rafael Menezes Gonçalves | Ajustes A1 a A3 e A9 no próprio código; apoio à integração das telas já entregues com o `FirebaseAuthRepository` | 1.5.2; 1.5.11 | RF11, RF18 |

### 6.3 Plano de entregas

| Data | Marco | Responsável |
|---|---|---|
| Ter, 17/11 | Checkpoint de abertura: tarefas confirmadas e uma branch por integrante | Todos |
| Qua, 18/11 | Firebase configurado no `main.dart`; interfaces dos repositórios de diário, PHQ-9 e configurações publicadas, com implementação em memória para ninguém ficar bloqueado | Franck |
| Qua, 18/11 | Tipografia Poppins e Inter e AppBar padrão com SOS na `main` | Murilo e Rene |
| Qua, 18/11 | Ajustes A1 a A3 na `main` | Rafael |
| Sex, 20/11 | Todas as telas navegáveis usando os repositórios em memória: Telas 02, 03, 05, 06, 07 e 08, recuperação de senha e Tela 04 | Franck, Murilo e Rene |
| Sex, 20/11 | `FirebaseAuthRepository` e repositórios do Firestore prontos; Security Rules publicadas | Franck |
| Sáb, 21/11 a dom, 22/11 | Troca das implementações em memória pelas do Firestore; Tela 09 Botão de Pânico; tema escuro, perfil e lembretes | Franck e Murilo |
| Seg, 23/11, até 18h | Última integração na `main`; app compilando e executando no emulador e em um Android real; build da apresentação gerado | Todos |

**Prioridade:** se faltar tempo, tema escuro (F10) e lembretes (F09) são os primeiros a sair da Sprint 4, porque são as funcionalidades de menor prioridade em docs/requisitos.md, seção 5. Nesse caso, entram até 25/11, antes dos testes.

**Regra de integração:** cada entrega entra na `main` por pull request de uma branch própria, revisada por outro integrante e testada no emulador antes do merge.

**Pronto quando:** o app abre no emulador e em um Android real; permite usar sem cadastro e também criar conta, entrar, sair e recuperar a senha; grava e lê diário e PHQ-9 no Firestore em modo avião; disca o 188 sem internet depois da confirmação, a partir de qualquer tela; e apaga todos os dados e a conta pelo Botão de Pânico.

## 7. Sprint 5 (24/11/2026 a 01/12/2026): testes, validações e acabamento

**Objetivo:** não implementar telas novas. A sprint serve para testar, validar as regras de negócio, corrigir defeitos e deixar o app estável para a entrega de 01/12.

| Integrante | Tarefas | Pacote EAP | Requisitos e itens |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Testes unitários de modelos (`toMap`/`fromMap`), `Criptografia` e repositórios; testes das Security Rules no emulador do Firebase; testes das Telas 04 e 09; teste de exclusão total offline e online | 1.6.1 | RF12, RF13, RNF03; Q1 a) iv |
| Murilo Pedral Mota | Testes de widget das Telas 02, 03 e 08 e do perfil; teste de funcionamento em modo avião; teste em Android real de entrada; diagrama do fluxo de navegação real | 1.2.6; 1.6.2; 1.6.3 | RF01 a RF04, RF16, RNF05, RNF07, RNF08; Q1 b) v |
| Rene Mendonça Marinho | Testes do escore e do intervalo de 7 dias do PHQ-9; testes de widget das Telas 05, 06 e 07 e da recuperação de senha; teste da discagem do 188 sem rede | 1.6.1 | RF06 a RF10, RF19; Q1 a) iv |
| Rafael Menezes Gonçalves | Testes dos validadores de e-mail e senha e testes de widget do onboarding, login, cadastro e Início; validação do fluxo de conta (uso anônimo → cadastro sem perder dados) | 1.6.1 | RF11, RF17, RF18 |
| Todos | `flutter analyze` sem avisos; revisão cruzada (cada um testa as telas de outro integrante); correção dos defeitos encontrados; slides e roteiro da defesa oral; atualização de README, CHANGELOG e docs/uso-de-ia.md | 1.7.1; 1.2.7 | Medida de Eficiência; Q1 b) vi |

**Datas:** 24/11, 1ª apresentação com o build de 23/11; 27/11, testes concluídos e lista de defeitos fechada; 30/11, congelamento de código; 01/12, 2ª apresentação e link do repositório no Teams. Depois do congelamento, só correções que impeçam o app de compilar ou executar (observação 6).

**Pronto quando:** todos os critérios de aceitação de docs/escopo.md, seção 10, estão marcados, os testes passam, e o link do repositório foi postado no Teams (1.7.2).

## 8. Riscos e respostas
 
| Risco | Impacto | Resposta planejada |
|---|---|---|
| Apresentar em 24/11 sem o app completo | Perda de pontos na Q1 a) | Telas navegáveis com repositórios em memória até 20/11, para que o app rode mesmo se a integração com o Firebase atrasar; F09 e F10 são os primeiros a sair se faltar tempo. |
| Sprint 5 sem tempo para implementar o que faltar | Testes e validações incompletos | Nenhuma tela nova entra depois de 25/11; o que não estiver pronto até lá fica registrado como fora da entrega. |
| Não há aditivo oficial de regras de negócio | Regras de Q1 a) iv sem fonte oficial | Regras consolidadas em docs/regras-de-negocio.md a partir dos documentos do grupo e das decisões registradas, revisadas nos checkpoints. |
| Projeto II pede tela de login, mas o RF11 proíbe cadastro | Conflito entre Q1 e) i e os requisitos | Cadastro opcional com e-mail e senha (F11); quem não quiser se cadastrar continua sem cadastro, de forma anônima (RF17). As telas de conta ficam fora do escopo de prototipação (1.3.1). |
| Código gerado por IA com erros que impeçam a execução | Perda de pontos (observação ao fim da Q1 a) | Toda contribuição roda no emulador antes do commit; erros e correções vão para docs/uso-de-ia.md. |
| Conflitos de merge em arquivos compartilhados (README, CHANGELOG, docs/requisitos.md) | Atraso e perda de commits | git pull antes de começar; uma branch por integrante e tarefa; merge pela ordem combinada no checkpoint. |
| Reinstalar o app apaga a conta anônima e os dados | Perda de histórico de quem usa sem cadastro | Comportamento aceito e informado ao usuário; quem quiser manter o histórico faz o cadastro opcional (F11; docs/regras-de-negocio.md, RN19). |
 
## 9. Ritual dos checkpoints semanais
 
Toda terça-feira, no checkpoint de abertura da sprint, o grupo:
 
1. Revisa o critério "Pronto quando" da sprint anterior e marca o status de cada tarefa no README.
2. Confere se cada entrega tem commit da conta do próprio responsável e entrada no CHANGELOG.
3. Confirma as tarefas da sprint seguinte e as dependências entre integrantes.
4. Registra no README os ajustes de planejamento, se houver.
 