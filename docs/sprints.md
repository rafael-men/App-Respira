## 5. Sprint 3 (17/11/2026 a 23/11/2026): app mínimo executável
 
*Objetivo:* ter o app compilando, autenticando de forma anônima, gravando no Firestore e cobrindo as funcionalidades essenciais (F01, F02, F04, F05, F06, F08), pronto para a apresentação de 24/11.
 
| Integrante | Tarefas | Pacote EAP | Requisitos |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Projeto Firebase e FlutterFire; autenticação anônima; Firestore com persistência offline; Security Rules; Tela 04 Respiração 4-7-8 | 1.4.1 a 1.4.4; 1.5.4 | RF05, RF11, RF16, RF17, RNF03, RNF04 |
| Murilo Pedral Mota | Base visual (tokens, componentes e AppBar com SOS); Tela 01 Início; Telas 02 e 03 Diário de humor | 1.5.1 a 1.5.3 | RF01 a RF04, RNF01 |
| Rene Mendonça Marinho | Protótipo e implementação da tela de entrada; Tela 07 CVV com número embutido | 1.3.1; 1.3.2; 1.5.6 | RF09, RF10, RF11 |
| Rafael Menezes Gonçalves | Tela 08 Configurações (tema e notificações gravados no Firestore); Tela 09 Botão de Pânico | 1.5.7; 1.5.8 | RF13, RF14, RF15 |
 
*Ordem de trabalho:* Franck sobe a configuração do Firebase e Murilo sobe a base visual até quarta-feira, 18/11. As demais telas partem dessas duas bases.
 
*Pronto quando:* o app abre no emulador, autentica sem pedir dados, grava e lê registros do diário no Firestore em modo avião, disca o 188 sem internet e apaga todos os dados pelo Botão de Pânico.
 
## 6. Sprint 4 (24/11/2026 a 30/11/2026): conclusão, qualidade e apresentação
 
*Objetivo:* completar as funcionalidades restantes (F03, F07, F09, F10), tratar as regras do aditivo e fechar a documentação e a apresentação.
 
| Integrante | Tarefas | Pacote EAP | Requisitos e itens |
|---|---|---|---|
| Franck Patrick Hora Vasconcelos | Tela 05 PHQ-9 (perguntas); criptografia no cliente; consolidação de docs/uso-de-ia.md | 1.4.5; 1.5.5; 1.2.7 | RF06, RF12; Q1 b) vi |
| Murilo Pedral Mota | Fluxo de navegação real; tratamento de falhas de conexão; teste em Android real de entrada | 1.2.6; 1.6.2; 1.6.3 | RNF05, RNF07, RNF08; Q1 b) v |
| Rene Mendonça Marinho | Tela 06 PHQ-9 (resultado e gráfico de evolução); validações e regras do aditivo nas telas do PHQ-9 e do CVV | 1.5.5; 1.6.1 | RF07, RF08; Q1 a) iv |
| Rafael Menezes Gonçalves | Notificações não invasivas; tema escuro fiel ao protótipo; validações e regras do aditivo nas telas de Configurações e Pânico | 1.5.9; 1.5.10; 1.6.1 | RF14, RF15; Q1 a) iv |
| Todos | Slides e roteiro da defesa oral, cada um apresentando o que implementou; entradas próprias em docs/uso-de-ia.md | 1.7.1; 1.2.7 | Medida de Eficiência |
 
*Congelamento de código:* 30/11/2026. Depois disso, só correções que impeçam o app de compilar ou executar (observação 6).
 
*Pronto quando:* todos os critérios de aceitação de docs/escopo.md, seção 10, estão marcados, e o link do repositório foi postado no Teams (1.7.2).
 
## 7. Riscos e respostas
 
| Risco | Impacto | Resposta planejada |
|---|---|---|
| Apresentar em 24/11 sem o app completo | Perda de pontos na Q1 a) | Sprint 3 entrega primeiro as funcionalidades essenciais; F03, F07, F09 e F10 ficam para a Sprint 4. |
| Aditivo de regras de negócio ainda não registrado no repositório | Diagrama de Casos de Uso e regras de Q1 a) iv incompletos | Registrar o aditivo em docs/ no checkpoint de 10/11, antes do Diagrama de Casos de Uso. |
| Projeto II pede tela de login, mas o RF11 proíbe cadastro | Conflito entre Q1 e) i e os requisitos | Tela de entrada sem campos de e-mail ou senha, que dispara a autenticação anônima (1.3.1). |
| Código gerado por IA com erros que impeçam a execução | Perda de pontos (observação ao fim da Q1 a) | Toda contribuição roda no emulador antes do commit; erros e correções vão para docs/uso-de-ia.md. |
| Conflitos de merge em arquivos compartilhados (README, CHANGELOG, docs/requisitos.md) | Atraso e perda de commits | git pull antes de começar; uma branch por integrante e tarefa; merge pela ordem combinada no checkpoint. |
| Reinstalar o app apaga a conta anônima e os dados | Perda de histórico do usuário | Comportamento aceito, coerente com o anonimato por padrão; já registrado em docs/escopo.md, seção 7 (sincronização entre aparelhos fora do escopo). |
 
## 8. Ritual dos checkpoints semanais
 
Toda terça-feira, no checkpoint de abertura da sprint, o grupo:
 
1. Revisa o critério "Pronto quando" da sprint anterior e marca o status de cada tarefa no README.
2. Confere se cada entrega tem commit da conta do próprio responsável e entrada no CHANGELOG.
3. Confirma as tarefas da sprint seguinte e as dependências entre integrantes.
4. Registra no README os ajustes de planejamento, se houver.
 