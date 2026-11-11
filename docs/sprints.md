# Projeto Unidade II: Planejamento do Desenvolvimento em Sprints
 
Projeto Respira, aplicativo de saúde mental e apoio emocional
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 d) iii) (parte de 1,0 ponto)
 
| Campo | Preenchimento |
|---|---|
| Seção | Planejamento do desenvolvimento em sprints (Q1 d) iii) |
| Autores desta seção | Rene Mendonça Marinho (seções 1 a 4) e Rafael Menezes Gonçalves (seções 5 a 8) |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | Enunciado do Projeto II, docs/escopo.md, docs/eap.md, docs/requisitos.md e a divisão de telas da Atividade 04 no README |
 
O planejamento distribui os pacotes de trabalho de docs/eap.md em quatro sprints semanais, alinhadas aos checkpoints semanais exigidos pelo Projeto II (observação 1 e Q1 c) iii). Os códigos entre parênteses (ex.: 1.5.3) remetem à EAP.
 
## 1. Premissas do planejamento
 
- Sprints de uma semana, de terça a segunda-feira, com checkpoint toda terça-feira, no dia da aula.
- As apresentações acontecem em 24/11/2026 e 01/12/2026. Como o grupo pode apresentar já no dia 24/11, *o app precisa compilar e executar ao fim da Sprint 3 (23/11/2026)*. A Sprint 4 completa e estabiliza o que faltar.
- A implementação de cada tela fica com o integrante que desenhou essa tela no protótipo de baixa fidelidade (README, Atividade 04), para aproveitar o conhecimento já adquirido e dar evidência de código a todos (Q1 c) i).
- Cada integrante registra no CHANGELOG o que fez e atualiza o status no README no mesmo commit da entrega (Q1 c) ii).
- Cada integrante registra em docs/uso-de-ia.md os prompts, erros e soluções da própria parte (Q1 b) vi).
 
## 2. Calendário
 
| Sprint | Período | Checkpoint de abertura | Objetivo |
|---|---|---|---|
| Sprint 1 | 03/11/2026 a 09/11/2026 | 03/11/2026 | Adaptar a documentação existente ao Firebase |
| Sprint 2 | 10/11/2026 a 16/11/2026 | 10/11/2026 | Planejamento e modelagem: escopo, EAP, sprints, casos de uso, classes e banco de dados |
| Sprint 3 | 17/11/2026 a 23/11/2026 | 17/11/2026 | App mínimo executável: Firebase, base visual e funcionalidades essenciais |
| Sprint 4 | 24/11/2026 a 30/11/2026 | 24/11/2026 (1ª apresentação) | Funcionalidades restantes, qualidade, documentação final e apresentação |
| Entrega | 01/12/2026 | 01/12/2026 (2ª apresentação) | Defesa oral e link do repositório no Teams |
 
## 3. Sprint 1 (03/11/2026 a 09/11/2026): Firebase na documentação
 
**Objetivo:** endossar a decisão por Firebase Authentication anônimo e Cloud Firestore com persistência offline em todos os documentos existentes (1.2.1).
 
| Integrante | Tarefas | Pacote EAP |
|---|---|---|
| Franck Patrick Hora Vasconcelos | Endosso em estudo de caso (seção 1), benchmark, RF11, RF12, RF13 e novo RF17 em requisitos, seção 7 de justificativas e README | 1.2.1 |
| Murilo Pedral Mota | Endosso em estudo de caso (seção 3), pesquisa (3.2, 3.4 e síntese), RNF03, RNF06 e RNF07, serviços de nuvem (Firebase) na seção 8 de justificativas (Arquitetura do sistema) | 1.2.1 |
| Rafael Menezes Gonçalves | Endosso na persona 1, CRUD ligado às coleções do Firestore e reposicionamento do RF16, seção 4 de justificativas | 1.2.1 |
| Rene Mendonça Marinho | Endosso em estudo de caso (seções 6, 7 e 8.1), persona 2, F05 a F08, seção 8 de justificativas | 1.2.1 |
 
**Pronto quando:** nenhum documento afirma "não existe conta" sem qualificar como conta anônima, e nenhum cita Hive ou SQLite como armazenamento principal.
 
## 4. Sprint 2 (10/11/2026 a 16/11/2026): planejamento e modelagem
 
**Objetivo:** fechar o planejamento (Q1 d) e a modelagem (Q1 b) i a iv) antes de escrever código.
 
| Integrante | Tarefas | Pacote EAP | Item do Projeto II |
|---|---|---|---|
| Murilo Pedral Mota | Escopo do projeto (docs/escopo.md); Diagrama de Classes (docs/diagrama-classes.md) | 1.1.1; 1.2.3 | Q1 d) i; Q1 b) ii |
| Franck Patrick Hora Vasconcelos | EAP simplificada (docs/eap.md); Diagrama de Casos de Uso (docs/diagrama-casos-de-uso.md) | 1.1.2; 1.2.2 | Q1 d) ii; Q1 b) i |
| Rene Mendonça Marinho | Planejamento em sprints, seções 1 a 4 (docs/sprints.md); mapeamento das classes Dart para o Firestore | 1.1.3; 1.2.5 | Q1 d) iii; Q1 b) iv |
| Rafael Menezes Gonçalves | Planejamento em sprints, seções 5 a 8 (docs/sprints.md); modelagem das coleções e documentos do Firestore | 1.1.3; 1.2.4 | Q1 d) iii; Q1 b) iii |
 
**Dependências internas:** o Diagrama de Classes (Murilo) é a entrada do mapeamento Dart → Firestore (Rene) e deve ficar pronto até quinta-feira, 12/11. A modelagem do Firestore (Rafael) e o mapeamento (Rene) precisam usar os mesmos nomes de coleção.
 
**Pronto quando:** os quatro diagramas e modelagens estão em docs/, com nomes de entidades e coleções coerentes entre si e com docs/requisitos.md.

## 5. Sprint 3 (17/11/2026 a 23/11/2026): app mínimo executável
 
**Objetivo:** ter o app compilando, autenticando de forma anônima, gravando no Firestore e cobrindo as funcionalidades essenciais (F01, F02, F04, F05, F06, F08), pronto para a apresentação de 24/11.
 
| Integrante | Tarefas | Pacote EAP | Requisitos |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Projeto Firebase e FlutterFire; autenticação anônima e por e-mail e senha, com vinculação de contas; Firestore com persistência offline; Security Rules; Tela 04 Respiração 4-7-8 | 1.4.1 a 1.4.4; 1.5.4 | RF05, RF11, RF16 a RF19, RNF03, RNF04 |
| Murilo Pedral Mota | Base visual (tokens, componentes e AppBar com SOS); Tela 01 Início; Telas 02 e 03 Diário de humor | 1.5.1 a 1.5.3 | RF01 a RF04, RNF01 |
| Rene Mendonça Marinho | Telas de login, cadastro e recuperação de senha (sem protótipo); Tela 07 CVV com número embutido | 1.3.1; 1.3.2; 1.5.6; 1.5.11 | RF09, RF10, RF11, RF18, RF19 |
| Rafael Menezes Gonçalves | Tela 08 Configurações (tema e notificações gravados no Firestore); Tela 09 Botão de Pânico | 1.5.7; 1.5.8 | RF13, RF14, RF15 |
 
**Ordem de trabalho:** Franck sobe a configuração do Firebase e Murilo sobe a base visual até quarta-feira, 18/11. As demais telas partem dessas duas bases.
 
**Pronto quando:** o app abre no emulador, permite usar sem cadastro e também criar conta e entrar com e-mail e senha, grava e lê registros do diário no Firestore em modo avião, disca o 188 sem internet e apaga todos os dados pelo Botão de Pânico.
 
## 6. Sprint 4 (24/11/2026 a 30/11/2026): conclusão, qualidade e apresentação
 
**Objetivo:** completar as funcionalidades restantes (F03, F07, F09, F10), tratar as regras de negócio de docs/regras-de-negocio.md e fechar a documentação e a apresentação.
 
| Integrante | Tarefas | Pacote EAP | Requisitos e itens |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Tela 05 PHQ-9 (perguntas); criptografia no cliente; consolidação de docs/uso-de-ia.md | 1.4.5; 1.5.5; 1.2.7 | RF06, RF12; Q1 b) vi |
| Murilo Pedral Mota | Fluxo de navegação real; tratamento de falhas de conexão; teste em Android real de entrada | 1.2.6; 1.6.2; 1.6.3 | RNF05, RNF07, RNF08; Q1 b) v |
| Rene Mendonça Marinho | Tela 06 PHQ-9 (resultado e gráfico de evolução); validações e regras de negócio nas telas do PHQ-9 e do CVV | 1.5.5; 1.6.1 | RF07, RF08; Q1 a) iv |
| Rafael Menezes Gonçalves | Notificações não invasivas; tema escuro fiel ao protótipo; perfil opcional (nome de usuário e foto) em Configurações; validações e regras de negócio nas telas de Configurações e Pânico | 1.5.9; 1.5.10; 1.5.11; 1.6.1 | RF14, RF15, RF20; Q1 a) iv |
| Todos | Slides e roteiro da defesa oral, cada um apresentando o que implementou; entradas próprias em docs/uso-de-ia.md | 1.7.1; 1.2.7 | Medida de Eficiência |
 
**Congelamento de código:** 30/11/2026. Depois disso, só correções que impeçam o app de compilar ou executar (observação 6).
 
**Pronto quando:** todos os critérios de aceitação de docs/escopo.md, seção 10, estão marcados, e o link do repositório foi postado no Teams (1.7.2).
 
## 7. Riscos e respostas
 
| Risco | Impacto | Resposta planejada |
|---|---|---|
| Apresentar em 24/11 sem o app completo | Perda de pontos na Q1 a) | Sprint 3 entrega primeiro as funcionalidades essenciais; F03, F07, F09 e F10 ficam para a Sprint 4. |
| Não há aditivo oficial de regras de negócio | Regras de Q1 a) iv sem fonte oficial | Regras consolidadas em docs/regras-de-negocio.md a partir dos documentos do grupo e das decisões registradas, revisadas nos checkpoints. |
| Projeto II pede tela de login, mas o RF11 proíbe cadastro | Conflito entre Q1 e) i e os requisitos | Cadastro opcional com e-mail e senha (F11); quem não quiser se cadastrar continua sem cadastro, de forma anônima (RF17). As telas de conta ficam fora do escopo de prototipação (1.3.1). |
| Código gerado por IA com erros que impeçam a execução | Perda de pontos (observação ao fim da Q1 a) | Toda contribuição roda no emulador antes do commit; erros e correções vão para docs/uso-de-ia.md. |
| Conflitos de merge em arquivos compartilhados (README, CHANGELOG, docs/requisitos.md) | Atraso e perda de commits | git pull antes de começar; uma branch por integrante e tarefa; merge pela ordem combinada no checkpoint. |
| Reinstalar o app apaga a conta anônima e os dados | Perda de histórico de quem usa sem cadastro | Comportamento aceito e informado ao usuário; quem quiser manter o histórico faz o cadastro opcional (F11; docs/regras-de-negocio.md, RN19). |
 
## 8. Ritual dos checkpoints semanais
 
Toda terça-feira, no checkpoint de abertura da sprint, o grupo:
 
1. Revisa o critério "Pronto quando" da sprint anterior e marca o status de cada tarefa no README.
2. Confere se cada entrega tem commit da conta do próprio responsável e entrada no CHANGELOG.
3. Confirma as tarefas da sprint seguinte e as dependências entre integrantes.
4. Registra no README os ajustes de planejamento, se houver.
 