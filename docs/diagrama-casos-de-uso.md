# Projeto Unidade II: Diagrama de Casos de Uso

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 b) i) (parte de 2,0 pontos)

| Campo | Preenchimento |
|---|---|
| Seção | Diagrama de Casos de Uso atualizado com as novas regras de negócio (Q1 b) i) |
| Autor desta seção | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | `docs/requisitos.md` (F01 a F11, RF01 a RF20, CRUD), `docs/escopo.md`, `docs/justificativas.md` (seções 4 e 8) e a decisão por Firebase da Sprint 1 |

O diagrama representa o que o usuário faz no Respira e quais sistemas externos participam de cada ação. Ele atualiza a visão da Unidade I com as regras de negócio da Unidade II: autenticação no Firebase (anônima, para quem usa sem cadastro, ou com e-mail e senha, no cadastro opcional), gravação no Cloud Firestore com funcionamento offline, controle de acesso por usuário e exclusão também na nuvem pelo Botão de Pânico.

## 1. Atores

| Ator | Tipo | Papel |
|---|---|---|
| Usuário | Principal (humano) | Pessoa que usa o app sem se identificar. Representa as personas Marina Souza (crise) e Lucas Andrade (rotina), conforme `docs/personas.md`. |
| Firebase Authentication | Secundário (sistema externo) | Cria e mantém a conta (anônima ou com e-mail e senha), envia o e-mail de recuperação de senha e exclui a conta no Botão de Pânico. |
| Cloud Firestore | Secundário (sistema externo) | Guarda diário, PHQ-9 e configurações, com cache offline e sincronização posterior. |
| Telefone do aparelho | Secundário (sistema externo) | Recebe o número 188 e faz a ligação ao CVV, sem depender de internet. |
| Sistema de notificações do aparelho | Secundário (sistema externo) | Exibe os lembretes motivacionais quando ativados. |

## 2. Descrição dos casos de uso

| Caso de uso | Descrição | Requisitos |
|---|---|---|
| UC01 Entrar no app | No primeiro acesso, a tela de login oferece entrar, criar conta ou continuar sem cadastro. Quem continua sem cadastro é autenticado pelo provedor anônimo, sem informar dados pessoais. Nos acessos seguintes, o app reaproveita a sessão e abre direto no Início. | F06, RF11, RF17 |
| UC02 Registrar humor | O usuário escolhe um entre cinco emojis e, se quiser, escreve uma nota curta. Data e hora são gravadas automaticamente. | F01, RF01, RF02 |
| UC03 Consultar histórico do diário | Lista os registros em ordem cronológica, inclusive sem internet. | RF03, RF16 |
| UC04 Excluir registro de humor | Remove um registro específico do diário. | RF04 |
| UC05 Fazer respiração guiada 4-7-8 | A animação começa sozinha e repete os ciclos 4s, 7s e 8s até o usuário tocar em "Voltar". Não lê nem grava dados. | F02, RF05, RNF04 |
| UC06 Responder PHQ-9 | Apresenta as nove perguntas, uma por tela, na aplicação semanal. | F03, RF06 |
| UC07 Calcular escore do PHQ-9 | Soma as respostas ao final do questionário e guarda o escore com a data. | RF07 |
| UC08 Ver evolução do PHQ-9 | Exibe o gráfico dos escores ao longo do tempo. | RF08 |
| UC09 Ligar para o CVV (188) | Um toque no botão vermelho da AppBar, a partir de qualquer tela, abre a confirmação e disca o 188. O número é embutido no app. | F04, RF09, RF10 |
| UC10 Alternar tema claro/escuro | Liga ou desliga o tema escuro. | F10, RF15 |
| UC11 Ativar/desativar notificações | Liga ou desliga os lembretes motivacionais. | F09, RF14 |
| UC12 Acionar Botão de Pânico | Depois da confirmação, apaga os dados locais, os documentos do usuário no Firestore e a conta (anônima ou cadastrada). | F08, RF13 |
| UC13 Criptografar dados sensíveis | Cifra a nota do diário e as respostas do PHQ-9 no aparelho, antes do envio ao Firestore. | F07, RF12 |
| UC14 Gravar e sincronizar dados | Grava primeiro no cache local do Firestore e sincroniza quando a conexão volta. | F05, RF16, RNF06, RNF07 |
| UC15 Criar conta | O usuário informa e-mail e senha. Se já usava o app sem cadastro, a conta anônima é vinculada à nova conta e os dados são mantidos. | F11, RF18 |
| UC16 Entrar com e-mail e senha | O usuário cadastrado entra na conta, inclusive depois de reinstalar o app ou em outro aparelho, e recupera o histórico. | F11, RF19 |
| UC17 Recuperar senha | O usuário informa o e-mail e recebe um link para redefinir a senha. | F11, RF19 |
| UC18 Editar perfil | O usuário cadastrado define, altera ou remove o nome de usuário e a foto, ambos opcionais. | F11, RF20 |

## 3. Regras de negócio

| Regra | Descrição | Casos de uso | Origem |
|---|---|---|---|
| RN01 | O uso sem cadastro é anônimo e não pede dados pessoais; o cadastro é opcional e pede só e-mail e senha. | UC01, UC15 | RF11, RF17, RF18; `docs/estudo-de-caso.md`, seção 8.1 |
| RN02 | Cada usuário só lê e grava os próprios dados, garantido pelas Security Rules do Firestore. | UC03, UC08, UC12, UC14 | RNF03 |
| RN03 | Um registro de humor não pode ser editado. Para corrigir, o usuário exclui e cria outro. | UC02, UC04 | `docs/requisitos.md`, seção 4 (CRUD) |
| RN04 | Uma resposta do PHQ-9 não pode ser editada nem excluída individualmente. Só o Botão de Pânico remove esses dados. | UC06, UC12 | `docs/requisitos.md`, seção 4 (CRUD) |
| RN05 | Nenhuma funcionalidade crítica depende de rede: o diário funciona offline e o CVV disca sem internet. | UC02, UC03, UC09, UC14 | RF10, RF16, RNF07 |
| RN06 | A nota do diário e as respostas do PHQ-9 vão para a nuvem já cifradas. | UC13 | RF12 |
| RN07 | O Botão de Pânico exige confirmação em página inteira e apaga primeiro os dados locais, sem esperar resposta da nuvem. Para usuário cadastrado, a exclusão da conta pede a senha de novo. | UC12 | RF13; `docs/justificativas.md`, seções 4 e 8 |
| RN08 | O número do CVV é fixo e não pode ser alterado pelo usuário. | UC09 | `docs/requisitos.md`, seção 4 (CRUD) |

As regras RN01 a RN08 estão consolidadas, junto com as demais regras de negócio do projeto (inclusive as de conta, RN18 a RN21), em [`docs/regras-de-negocio.md`](regras-de-negocio.md).

## 4. Código-fonte em PlantUML

@startuml
left to right direction
skinparam packageStyle rectangle

actor "Usuário" as U
actor "Firebase Authentication" as AUTH <<sistema>>
actor "Cloud Firestore" as FS <<sistema>>
actor "Telefone do aparelho" as TEL <<sistema>>
actor "Notificações do aparelho" as NOT <<sistema>>

rectangle "Sistema Respira" {
  usecase "UC01 Entrar no app\n(sem cadastro ou com conta)" as UC01
  usecase "UC02 Registrar humor" as UC02
  usecase "UC03 Consultar histórico do diário" as UC03
  usecase "UC04 Excluir registro de humor" as UC04
  usecase "UC05 Fazer respiração guiada 4-7-8" as UC05
  usecase "UC06 Responder PHQ-9" as UC06
  usecase "UC07 Calcular escore do PHQ-9" as UC07
  usecase "UC08 Ver evolução do PHQ-9" as UC08
  usecase "UC09 Ligar para o CVV (188)" as UC09
  usecase "UC10 Alternar tema claro/escuro" as UC10
  usecase "UC11 Ativar/desativar notificações" as UC11
  usecase "UC12 Acionar Botão de Pânico" as UC12
  usecase "UC13 Criptografar dados sensíveis" as UC13
  usecase "UC14 Gravar e sincronizar dados" as UC14
  usecase "UC15 Criar conta" as UC15
  usecase "UC16 Entrar com e-mail e senha" as UC16
  usecase "UC17 Recuperar senha" as UC17
  usecase "UC18 Editar perfil" as UC18
}

U -- UC01
U -- UC02
U -- UC03
U -- UC04
U -- UC05
U -- UC06
U -- UC08
U -- UC09
U -- UC10
U -- UC11
U -- UC12
U -- UC15
U -- UC16
U -- UC17
U -- UC18

UC02 ..> UC13 : <<include>>
UC06 ..> UC13 : <<include>>
UC06 ..> UC07 : <<include>>
UC02 ..> UC14 : <<include>>
UC04 ..> UC14 : <<include>>
UC06 ..> UC14 : <<include>>
UC10 ..> UC14 : <<include>>
UC11 ..> UC14 : <<include>>
UC18 ..> UC14 : <<include>>
UC15 ..> UC01 : <<extend>>

UC01 -- AUTH
UC12 -- AUTH
UC15 -- AUTH
UC16 -- AUTH
UC17 -- AUTH
UC03 -- FS
UC08 -- FS
UC12 -- FS
UC14 -- FS
UC09 -- TEL
UC11 -- NOT
@enduml

Diagrama gerado no [PlantText](https://www.planttext.com/). Versão renderizada: [`docs/diagrama-casos-de-uso.pdf`](diagrama-casos-de-uso.pdf).
