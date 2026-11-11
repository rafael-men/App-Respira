# Projeto Unidade II: Escopo do Projeto
 
_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 d) i) (parte de 1,0 ponto)
 
| Campo | Preenchimento |
|---|---|
| Seção | Escopo do projeto (Q1 d) i) |
| Autor desta seção | Murilo Pedral Mota |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | `docs/estudo-de-caso.md`, `docs/pesquisa.md`, `docs/personas.md`, `docs/benchmark.md`, `docs/requisitos.md`, `docs/justificativas.md`, `docs/prototipoAltaFidelidade.pdf` |
 
Este documento delimita o que o Respira vai entregar na Unidade II. Nenhuma funcionalidade nova é criada aqui: o escopo é recortado a partir das funcionalidades F01 a F11 e dos requisitos RF01 a RF20 e RNF01 a RNF08 já definidos em `docs/requisitos.md`, das personas Marina Souza e Lucas Andrade (`docs/personas.md`) e da stack obrigatória do Projeto II (Dart, Flutter e Firebase).
 
## 1. Objetivo do projeto
 
Entregar o aplicativo Respira funcional em Flutter, compilando e executando em emulador e em dispositivo Android real, com autenticação e banco de dados no Firebase. O app deve reunir as três frentes definidas no estudo de caso (seção 4): alívio imediato (respiração guiada 4-7-8), autoconhecimento (diário de humor e PHQ-9 semanal) e acesso rápido à rede de apoio (CVV 188).
 
## 2. Justificativa
 
| Evidência | Fonte | Consequência para o escopo |
|---|---|---|
| 26,8% dos brasileiros têm ansiedade e 12,7% têm depressão | `docs/pesquisa.md`, seção 2.1 | O núcleo do app (respiração, diário, PHQ-9) atende ao problema mais frequente. |
| Estigma pesa mais que barreiras estruturais | `docs/pesquisa.md`, seção 3.1 | Uso anônimo entra no escopo como requisito, não como opção. |
| 10,9% da população segue digitalmente excluída | `docs/pesquisa.md`, seção 3.2 | Funcionamento offline do diário e do CVV entra no escopo. |
| 22 de 32 apps de saúde mental reprovados em privacidade | `docs/pesquisa.md`, seção 3.4 | Criptografia e Botão de Pânico entram no escopo. |
| Nenhuma solução do benchmark cobre as três frentes juntas | `docs/benchmark.md`, síntese | O escopo integra as três frentes em um único app. |
 
## 3. Público e personas atendidas
 
| Persona | Perfil de engajamento | O que o escopo precisa garantir para ela |
|---|---|---|
| Marina Souza (prioritária) | Emergencial/crise | CVV a 1 toque em qualquer tela, funcionando sem internet; respiração que começa sozinha; nenhum cadastro obrigatório. |
| Lucas Andrade | Diário/rotina | Diário em poucos toques; PHQ-9 semanal com gráfico de evolução; uso discreto; cadastro opcional para não perder o histórico. |
 
Os quatro públicos do estudo de caso (adultos, universitários, professores e pacientes de CAPS) estão representados por essas duas personas, conforme `docs/personas.md`.
 
## 4. Escopo do produto (o que será entregue)
 
| Funcionalidade | Requisitos | Prioridade (`docs/requisitos.md`, seção 5) | Persona principal |
|---|---|---|---|
| F01 Diário de humor com emojis | RF01, RF02, RF03, RF04 | Essencial | Lucas e Marina |
| F02 Respiração guiada 4-7-8 | RF05, RNF04 | Essencial | Marina |
| F03 PHQ-9 semanal com gráfico | RF06, RF07, RF08 | Importante | Lucas |
| F04 CVV (188) em 1 toque | RF09 | Essencial | Marina |
| F05 Funcionamento offline do diário e do CVV | RF10, RF16, RNF07 | Essencial | Marina |
| F06 Uso anônimo, sem cadastro | RF11 e RF17 (autenticação anônima) | Essencial | Marina e Lucas |
| F07 Criptografia dos dados | RF12, RNF03 | Essencial | Marina e Lucas |
| F08 Botão de Pânico | RF13 | Essencial | Marina |
| F09 Notificações não invasivas | RF14 | Importante | Lucas |
| F10 Tema claro/escuro | RF15 | Secundária | Marina e Lucas |
| F11 Cadastro opcional com e-mail e senha | RF18, RF19, RF20 | Essencial | Lucas |
 
F10 permanece no escopo, mesmo sendo secundária, porque o protótipo de alta fidelidade já traz a variante escura da Tela 01 (`docs/justificativas.md`, seção 7) e o Projeto II exige telas fiéis ao protótipo (Q1 a) iii). Por ser secundária, é a última funcionalidade do cronograma.
 
Telas no escopo, conforme o protótipo de alta fidelidade: 01 Início (home), 02 Diário (registro), 03 Diário (histórico), 04 Respiração Guiada, 05 PHQ-9 (pergunta), 06 PHQ-9 (resultado), 07 Confirmação de chamada ao CVV, 08 Configurações e 09 Confirmação do Botão de Pânico. Além delas, o app terá as telas de conta: login (e-mail e senha, com as opções "Criar conta", "Esqueci minha senha" e "Continuar sem cadastro"), cadastro, recuperação de senha e perfil (nome de usuário e foto, opcionais). A tela de login atende ao Projeto II (Q1 e) i; `docs/eap.md`, pacote 1.3.1). As telas de conta não fazem parte do escopo de prototipação: não terão protótipo de baixa nem de alta fidelidade e ficam registradas apenas nos documentos (`docs/regras-de-negocio.md`, RN11).

As telas principais são quatro, conforme a restrição do estudo de caso (`docs/estudo-de-caso.md`, seção 7): Diário de humor, Respiração Guiada, PHQ-9 e acesso ao CVV. As demais (telas de conta, Início, histórico do diário, resultado do PHQ-9, confirmações e Configurações) são telas secundárias ou de confirmação (`docs/regras-de-negocio.md`, RN12).
 
## 5. Escopo técnico
 
| Item | Definição |
|---|---|
| Linguagem e framework | Dart e Flutter (Q1 a) i) |
| Autenticação | Firebase Authentication: provedor anônimo para quem usa sem cadastro e provedor e-mail/senha para o cadastro opcional, com recuperação de senha por e-mail. A conta anônima é vinculada à conta cadastrada, preservando os dados (F06, F11, RF11, RF17 a RF19) |
| Perfil | Nome de usuário e foto opcionais, gravados no documento do usuário no Firestore; a foto é reduzida no aparelho antes do envio (RF20) |
| Banco de dados | Cloud Firestore com persistência offline (F05, RF16, RNF06) |
| Controle de acesso | Firestore Security Rules restringindo cada usuário aos próprios documentos (RNF03) |
| Número do CVV | Constante embutida no app, sem dependência de rede ou do Firebase (RF10, `docs/justificativas.md`, seção 8) |
| Plataforma de teste | Emulador e pelo menos um Android real de entrada (RNF05, RNF08) |
 
## 6. Entregáveis do projeto
 
| Entregável | Item do Projeto II |
|---|---|
| Código-fonte do app em Flutter, compilando e executando | Q1 a) i a iv |
| Diagrama de Casos de Uso atualizado | Q1 b) i |
| Diagrama de Classes (modelos de domínio) | Q1 b) ii |
| Modelagem do banco no Firestore e mapeamento das classes Dart para o Firestore | Q1 b) iii e iv |
| Fluxo de navegação real do app | Q1 b) v |
| `docs/uso-de-ia.md` (prompts, erros da IA, soluções e justificativa das bibliotecas) | Q1 b) vi |
| README.md e CHANGELOG.md atualizados continuamente | Q1 c) ii |
| Escopo, EAP e planejamento em sprints | Q1 d) i, ii e iii |
| Protótipos de baixa e alta fidelidade (home, funcionalidades e fluxo); as telas de conta ficam fora do escopo de prototipação | Q1 e) |
| Apresentação e defesa oral | Medida de Eficiência (2,0) |
 
## 7. Fora do escopo
 
| Item | Motivo |
|---|---|
| Substituir atendimento profissional ou emitir diagnóstico | O app é apoio entre atendimentos, nunca substituto (`docs/estudo-de-caso.md`, seção 4; `docs/pesquisa.md`, seção 6). |
| Cadastro obrigatório para usar o app | Contradiz F06, RF11 e a seção 8.1 do estudo de caso. O cadastro existe, mas é opcional (F11). |
| Login social (Google, Apple, Facebook) | O cadastro opcional usa só e-mail e senha (RF18). |
| Questionário GAD-7 | Aparece no estudo de caso e na pesquisa como referência, mas não foi definido como funcionalidade em `docs/requisitos.md`. |
| Chat, ligação ou integração com a API do CVV | O app apenas disca para o 188 (RF09); o atendimento é do próprio CVV. |
| Gamificação (sequências, conquistas, comparação) | Contradiz a identidade sem julgamento (`docs/benchmark.md`, Daylio; `docs/estudo-de-caso.md`, seção 5.4). |
| Manter os dados de quem usa sem cadastro ao reinstalar ou trocar de aparelho | A conta anônima fica vinculada ao aparelho. Quem quiser manter o histórico faz o cadastro opcional (F11). |
| Conteúdo pago, áudios e vídeos pesados | Contradiz o uso em aparelhos básicos e sem internet (`docs/benchmark.md`, Calm). |
| Publicação nas lojas (Google Play e App Store) | Não é exigida pelo Projeto II. |
 
## 8. Premissas
 
- O grupo é o mesmo da Unidade I e mantém o repositório `rafael-men/App-Respira` (observações 1 e 3 do Projeto II).
- Cada integrante faz commits com a própria conta do GitHub (Q1 c) i).
- Não há aditivo oficial de regras de negócio para este projeto. As regras consideradas no escopo estão consolidadas em `docs/regras-de-negocio.md`, a partir do que já está em `docs/` e das decisões registradas pelo grupo.
- O uso de IA generativa é permitido, desde que registrado em `docs/uso-de-ia.md` e compreendido pelo grupo (observação 7).
 
## 9. Restrições
 
- Stack obrigatória: Dart, Flutter e Firebase (observação 8).
- Apresentações em 24/11/2026 e 01/12/2026; o app precisa compilar e executar antes da primeira data (observações 2 e 6).
- Funcionalidade principal em até 3 interações e botão do CVV a 1 toque, com confirmação antes da discagem (RNF01, RF09).
- Sem pop-ups, vibração excessiva ou animações rápidas (RNF02).
- Nenhuma funcionalidade crítica pode depender de rede (RNF07).
 
## 10. Critérios de aceitação do escopo
 
- [ ] As 9 telas do protótipo de alta fidelidade e as telas de conta estão implementadas e navegáveis.
- [ ] Quem escolhe continuar sem cadastro usa o app de forma anônima, sem informar dados pessoais.
- [ ] O usuário consegue criar conta com e-mail e senha, entrar, sair, recuperar a senha e manter o histórico depois de reinstalar o app.
- [ ] Diário e PHQ-9 gravam e leem do Firestore e funcionam em modo avião.
- [ ] O botão do CVV disca o 188 sem internet, a partir de qualquer tela.
- [ ] O Botão de Pânico apaga o cache local, os documentos do usuário no Firestore e a conta (anônima ou cadastrada).
- [ ] O app foi executado em emulador e em um Android real de entrada.
- [ ] Todos os entregáveis da seção 6 estão no repositório.
 
---
