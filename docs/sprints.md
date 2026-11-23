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

### 6.2 Entregas por integrante (plano original de 17/11/2026, substituído pela seção 6.4)

| Integrante | Entregas | Pacote EAP | Requisitos |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Projeto Firebase e FlutterFire (`firebase_core`, `firebase_auth`, `cloud_firestore`); `FirebaseAuthRepository` (uso anônimo, cadastro com vinculação da conta anônima, login, recuperação de senha, saída e exclusão de conta); persistência offline; modelos e repositórios de dados (`Usuario`, `Configuracoes`, `RegistroHumor`, `RespostaPHQ9`) com `withConverter`; serviço `Criptografia`; publicação das Security Rules; **Tela 04 Respiração 4-7-8**; **Tela 09 Botão de Pânico**; ajustes A7 e A8 | 1.4.1 a 1.4.5; 1.5.4; 1.5.8 | RF05, RF11 a RF13, RF16 a RF19, RNF03, RNF04, RNF06 |
| Murilo Pedral Mota | Tipografia Poppins e Inter (A4); **Telas 02 e 03 Diário de humor** (registro com nota até 10.000 caracteres, histórico e exclusão), com o humor escolhido na Início levando direto à Tela 02; **Tela 08 Configurações** (tema e notificações gravados no Firestore); tema escuro; **perfil opcional** (nome de usuário e foto); lembretes não invasivos | 1.5.1; 1.5.3; 1.5.7; 1.5.9 a 1.5.11 | RF01 a RF04, RF14, RF15, RF20, RNF01 |
| Rene Mendonça Marinho | AppBar padrão com SOS em todas as telas (A5); **Tela 07 Confirmação de chamada ao CVV** (discagem do 188 com `url_launcher`, sem rede); **Telas 05 e 06 PHQ-9** (perguntas, escore, gráfico de evolução e intervalo de 7 dias); **tela de recuperação de senha** e opção de sair da conta (A6) | 1.5.5; 1.5.6; 1.5.11 | RF06 a RF10, RF19 |
| Rafael Menezes Gonçalves | Ajustes A1 a A3 e A9 no próprio código; apoio à integração das telas já entregues com o `FirebaseAuthRepository` | 1.5.2; 1.5.11 | RF11, RF18 |

### 6.3 Plano de entregas (plano original de 17/11/2026, substituído pela seção 6.4)

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

### 6.4 Replanejamento de 21/11/2026

A auditoria de 19/11/2026 comparou o código da `main` (commit `7b7646d`) com a documentação. As decisões do grupo sobre o resultado (P1 a P5, registradas em 21/11/2026) e o estado real levaram a este replanejamento. Ele substitui as seções 6.2 e 6.3 a partir de 21/11; o que já foi entregue continua com a autoria original.

**Situação dos ajustes da seção 6.1:** A1, A2, A3, A7 e A8 concluídos e cobertos por testes; A4, A5, A6 e A9 entram nas tarefas abaixo.

**Já concluído e comprovado (não gera tarefa):** Firebase configurado (Android, iOS e web), `FirebaseAuthRepository`, repositórios de diário, PHQ-9 e usuário, `Criptografia`, Security Rules publicadas e testadas no Firebase real (isolamento entre usuários), Telas 04 e 09, onboarding com preferências salvas, sessão mantida ao reabrir o app no navegador, vínculo da conta anônima ao cadastro testado na API do Firebase; `flutter analyze` sem erros e 34 testes passando.

**Decisões do grupo que entram no plano:** P1, todos usam o Flutter 3.50.0 e o `pubspec.lock` é regenerado uma vez; P2, as Telas 04 e 09 e a Início ficam como estão, e as diferenças em relação ao protótipo são registradas como decisão do grupo; P3, faixas padrão do PHQ-9; P4, cartão de apoio com acesso ao CVV quando a pergunta 9 do PHQ-9 for maior que zero; P5, aviso com confirmação antes de entrar numa conta existente quando houver dados feitos sem cadastro.

#### Lista única de tarefas

Prioridade: **P0** até domingo 22/11 (outros dependem); **P1** até segunda 23/11, 18h (necessário para a apresentação de 24/11); **P2** até quarta 25/11 (último prazo para telas e funcionalidades, seção 8). Esforço relativo: P (pequeno), M (médio), G (grande).

| ID | Resultado esperado | Origem | Responsável | Prioridade | Esforço | Depende de | Critério de aceite |
|---|---|---|---|---|---|---|---|
| T01 | Flutter 3.50.0 em todas as máquinas e `pubspec.lock` regenerado | Auditoria B1; P1 | Franck | P0 | P | Sem dependência | `flutter pub get --enforce-lockfile` funciona com o Flutter 3.50.0 nas quatro máquinas |
| T02 | O Botão de Pânico também apaga as preferências do onboarding salvas no aparelho | Auditoria B2; RF13, RN07 | Franck | P1 | P | T01 | Depois do Pânico, nenhuma preferência do onboarding continua no aparelho |
| T03 | Aviso com confirmação antes de entrar numa conta existente quando há dados feitos sem cadastro | Auditoria B8; P5; RN19 | Rafael | P1 | M | T06 (texto da regra) | Com registros sem cadastro, "Entrar" mostra o aviso; "Cancelar" não troca de conta |
| T04 | Tela 04 anuncia ao leitor de tela só a troca de etapa, não cada segundo | Auditoria B9 | Franck | P2 | P | N01 | Leitor de tela anuncia "Inspire", "Segure" e "Expire", uma vez por etapa |
| T05 | Tipografia Poppins (títulos e botões) e Inter (corpo) | Auditoria B6; ajuste A4 | Murilo | P0 | M | T01 | Fontes embutidas no app; nenhum uso de Libre Baskerville |
| T06 | Regras novas RN22 a RN25 (P2 a P5) e textos ligados a elas | P2 a P5 | Franck | P0 | M | Sem dependência | Regras publicadas em docs/regras-de-negocio.md antes de 22/11 |
| T07 | CHANGELOG e README de Rafael corrigidos (data e posição da entrada; status) | Auditoria, seção E | Rafael | P1 | P | Sem dependência | Entrada datada de 17/11 na ordem cronológica; status coerente com o código |
| T08 | Classe `Criptografia` no Diagrama de Classes com os métodos do código | Auditoria, seção D; M7 | Murilo | P2 | P | Sem dependência | Diagrama e PDF com `gerarChave`, `definirChave`, `cifrar`, `decifrar` e `limpar` |
| N01 | AppBar padrão com o botão SOS (contrato usado por todos) | Ajuste A5; RF09 | Rene | P0 | P | T01 | `RespiraAppBar` na `main` até 21/11, 22h |
| N02 | Tela 07: confirmação e discagem do 188, com número embutido | F04; RF09, RF10, RN08, RN09 | Rene | P0 | M | N01 | "Ligar agora" abre o discador com 188; "Cancelar" volta |
| N03 | SOS abre a Tela 07 na Início e nas Telas 04 e 09 | Auditoria B3 | Rene | P1 | P | N01, N02 | Nenhum SOS mostra "Disponível em breve." |
| N04 | AppBar padrão com SOS no onboarding, no login e no cadastro | Ajuste A9; RN18 | Rafael | P1 | P | N01 | As três telas mostram o SOS |
| N05 | Telas 02 e 03: registro, histórico e exclusão do diário; card e seletor de humor da Início levam à Tela 02 | F01; RF01 a RF04, RF16, RN03, RN16 | Murilo | P0 | G | N01, T05 | Registro aparece no histórico e no Firestore; excluir remove |
| N06 | Tela 08: tema, notificações, "Sobre o Respira", perfil e acesso ao Botão de Pânico | RF13 a RF15 | Murilo | P1 | M | N01, N10 (contrato), N11 (contrato) | Interruptores salvam no Firestore; cartão abre a Tela 09 |
| N07 | Telas 05 e 06: PHQ-9 com perguntas, escore, faixas, cartão de apoio, gráfico e intervalo de 7 dias | F03; RF06 a RF08, RN14, RN17, RN22, RN23 | Rene | P1 | G | N01, T06 | Resposta completa grava no Firestore e mostra escore, faixa e gráfico |
| N08 | Recuperação de senha e link "Esqueci minha senha" no login | RF19, RN21; ajuste A6 | Rafael | P1 | P | Sem dependência | Mensagem igual exista ou não a conta; e-mail recebido numa conta de teste |
| N09 | Sair da conta pelo ícone de conta da Início | RF19; ajuste A6 | Rafael | P1 | P | Sem dependência | Depois de sair, o app continua na Início, sem cadastro |
| N10 | Perfil opcional (nome de usuário e foto) | RF20, RN20 | Rafael | P1 | M | Sem dependência | Nome e foto salvos no Firestore; sem cadastro, o perfil não abre |
| N11 | Lembretes não invasivos (notificações locais) | F09, RF14 | Franck | P2 | M | T01 | Confirmar a ativação no onboarding ou em Configurações solicita permissão e agenda um lembrete diário no celular. Desativar em Configurações cancela |
| N12 | Tema escuro fiel ao protótipo | F10, RF15 | Rafael | P2 | M | T05, N05, N06 | Com o tema escuro ligado, fundo #191627 e cartões #241F38 em todas as telas |
| V01 | App compilado e executado num emulador Android | Observação 6; RNF05 | Franck | P1 | M | T01 | APK de depuração roda no emulador com onboarding, Início e Tela 04 |
| V02 | Cadastro com vínculo da conta anônima validado pelo app | RN19; auditoria F | Rafael | P1 | P | Sem dependência | Mesmo `uid` e mesmos registros antes e depois do cadastro (console do Firebase) |
| V03 | Diário validado no Firebase real pelo app | RF16; auditoria F | Murilo | P1 | P | N05 | Registro aparece no console do Firestore com a nota cifrada |
| V04 | PHQ-9 validado no Firebase real pelo app | RF06 a RF08; auditoria F | Rene | P1 | P | N07 | Resposta no console com `respostasCifradas` e escore; segunda tentativa no mesmo dia bloqueada |

#### Ordem de execução e integração

| Quando | O que entra na `main` |
|---|---|
| Sáb, 21/11, até 14h | T01 (Franck): lock regenerado; o grupo instala o Flutter 3.50.0 |
| Sáb, 21/11, até 22h | N01 (Rene), T05 (Murilo), T06 (Franck) e o contrato de N11 (Franck) |
| Dom, 22/11 | N02, N05, N08, N09, N10 e T02; mudanças na Início nesta ordem: Murilo (manhã), Rene (tarde), Rafael (noite) |
| Seg, 23/11, até 18h | N03, N04, N06, N07, T03, T07 e V01 a V04; build web e APK da apresentação |
| Até qua, 25/11 | N11, N12, T04 e T08 |

**Arquivos compartilhados:** cada trecho tem um único dono. Na tela Início (`home_page.dart`), a divisão é Diário, Configurações e seletor de humor (Murilo), SOS e PHQ-9 (Rene) e ícone de conta (Rafael). No `pubspec.yaml`, cada um acrescenta só as próprias dependências, com o Flutter 3.50.0, depois de `git pull`. O `main.dart` só é alterado por Rafael (tema escuro, N12).

**Prazo:** o volume é grande para 21/11 a 23/11. O caminho crítico é T01 → N01 → (N05, N07) → N03 → V01. Se faltar tempo, valem as regras já combinadas: P2 até 25/11, e o que não ficar pronto até lá é registrado como fora da entrega. Nenhuma funcionalidade P0 ou P1 sai sem decisão do grupo.

**Pronto quando (Sprint 4, a partir de 21/11):** as tarefas P0 e P1 estão na `main`; o app compila com o lock da T01 e roda no navegador (porta 5050) e no emulador Android; nenhum botão mostra "Disponível em breve."; V01 a V04 registrados com evidência.

#### Validação da integração em 22/11/2026

A integração de N04 e N12 (Murilo) reuniu as entregas de Rafael, Rene e Franck. T08 foi conferida no diagrama e no PDF. V01 e V03 têm evidências registradas, e o Galaxy A56 foi usado para a demonstração em aparelho. As verificações e os limites da evidência constam no [registro de uso de IA](uso-de-ia.md#53-verificações-e-limites-da-evidência).

## 7. Sprint 5 (24/11/2026 a 01/12/2026): testes, validações e acabamento

**Objetivo:** não implementar telas novas. A sprint serve para testar, validar as regras de negócio, corrigir defeitos e deixar o app estável para a entrega de 01/12.

| Integrante | Tarefas | Pacote EAP | Requisitos e itens |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Testes unitários de modelos (`toMap`/`fromMap`), `Criptografia` e repositórios; testes das Security Rules no emulador do Firebase; testes das Telas 04 e 09; teste de exclusão total offline e online; teste real dos lembretes num aparelho; consolidação de docs/uso-de-ia.md | 1.6.1; 1.2.7 | RF12, RF13, RF14, RNF03; Q1 a) iv; Q1 b) vi |
| Murilo Pedral Mota | Testes de widget das Telas 02, 03 e 08; teste de funcionamento em modo avião; teste em Android real de entrada; diagrama do fluxo de navegação real | 1.2.6; 1.6.2; 1.6.3 | RF01 a RF04, RF16, RNF05, RNF07, RNF08; Q1 b) v |
| Rene Mendonça Marinho | Testes do escore, das faixas, do cartão de apoio e do intervalo de 7 dias do PHQ-9; testes de widget das Telas 05, 06 e 07; teste da discagem do 188 sem rede num aparelho | 1.6.1 | RF06 a RF10; Q1 a) iv |
| Rafael Menezes Gonçalves | Testes dos validadores de e-mail e senha e testes de widget do onboarding, login, cadastro, Início, recuperação de senha, perfil e aviso de troca de conta; validação do fluxo de conta (uso anônimo → cadastro sem perder dados); tema escuro em todas as telas | 1.6.1 | RF11, RF15, RF17 a RF20 |
| Todos | `flutter analyze` sem avisos; revisão cruzada (cada um testa as telas de outro integrante); correção dos defeitos encontrados; slides e roteiro da defesa oral; atualização de README, CHANGELOG e docs/uso-de-ia.md | 1.7.1; 1.2.7 | Medida de Eficiência; Q1 b) vi |

**Datas:** 24/11, 1ª apresentação com o build de 23/11; 27/11, testes concluídos e lista de defeitos fechada; 30/11, congelamento de código; 01/12, 2ª apresentação e link do repositório no Teams. Depois do congelamento, só correções que impeçam o app de compilar ou executar (observação 6).

**Pronto quando:** todos os critérios de aceitação de docs/escopo.md, seção 10, estão marcados, os testes passam, e o link do repositório foi postado no Teams (1.7.2).

## 8. Riscos e respostas
 
| Risco | Impacto | Resposta planejada |
|---|---|---|
| Apresentar em 24/11 sem o app completo | Perda de pontos na Q1 a) | Telas navegáveis com repositórios em memória até 20/11, para que o app rode mesmo se a integração com o Firebase atrasar; F09 e F10 são os primeiros a sair se faltar tempo. Em 21/11, as telas de Murilo e Rene ainda não estavam na `main`: replanejamento na seção 6.4, com caminho crítico T01 → N01 → (N05, N07) → N03 → V01. |
| Versões diferentes do Flutter no grupo | O `pubspec.lock` muda a cada commit e o projeto não compila com as versões travadas | Todos usam o Flutter 3.50.0 e o lock é regenerado uma vez (T01, decisão P1). |
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
 