# Projeto Unidade II: Regras de Negócio

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 a) iv) e b) i)

| Campo | Preenchimento |
|---|---|
| Seção | Regras de negócio consolidadas (Q1 a) iv; Q1 b) i) |
| Autor desta seção | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 3 (10/11/2026 a 17/11/2026) |
| Base | `docs/diagrama-casos-de-uso.md`, `docs/requisitos.md`, `docs/estudo-de-caso.md`, `docs/diagrama-classes.md`, `docs/modelagem-firestore.md`, `docs/eap.md` e o enunciado do Projeto II |

> **Aviso:** não há aditivo oficial de regras de negócio para este projeto. Este documento consolida as regras que já estavam nos documentos de `docs/` e as decisões tomadas pelo grupo em 10/11/2026.

A numeração continua a de `docs/diagrama-casos-de-uso.md`, para não existirem duas sequências de regras no projeto.

## 1. Conta, acesso e privacidade

| ID | Descrição | Origem | Impacto |
|---|---|---|---|
| RN01 | O uso sem cadastro é anônimo: o app não pede nenhum dado pessoal. O cadastro é opcional e pede só e-mail e senha. | RF11, RF17, RF18; Projeto II, observação 8 e Q1 a) ii | UC01, UC15; `docs/modelagem-firestore.md`, seção 1 |
| RN02 | Cada usuário só lê e grava os próprios dados, garantido pelas Security Rules do Firestore. | RNF03 | Security Rules (`docs/modelagem-firestore.md`, seção 7); controle de acesso da Q1 a) iv |
| RN11 | O app tem o onboarding e as telas de conta (login, cadastro, recuperação de senha e perfil). Elas não fazem parte do escopo de prototipação: não têm protótipo de baixa nem de alta fidelidade e ficam registradas apenas nos documentos. | Projeto II, Q1 e) i; decisão do grupo (10/11/2026) | `docs/escopo.md`, seção 4; `docs/eap.md`, pacote 1.3.1 |
| RN18 | No primeiro acesso, o app abre o onboarding: três telas de apresentação e três perguntas opcionais (objetivo de uso, frequência de registro e lembretes), com a opção "Pular" em todas. Enquanto o usuário vê o onboarding, o app cria a conta anônima em segundo plano; ao concluir ou pular, abre a Tela 01 Início, sem cadastro. Esse primeiro acesso precisa de internet uma vez; sem conexão, a conta anônima é criada no acesso seguinte. Nos acessos seguintes, abre direto na Início. O login e o cadastro ficam no ícone de conta da barra superior da Início, que leva às telas de login ("Entrar" e "Esqueci minha senha") e de cadastro. O botão do CVV aparece em todas as telas, inclusive no onboarding e nas telas de conta. | Decisão do grupo (17/11/2026), alinhada ao código entregue na Sprint 3; RF09; RF11; RNF01 | UC01, UC15, UC16; fluxo de navegação (Q1 b) v) |
| RN19 | Sem cadastro, os dados ficam vinculados a uma conta anônima do aparelho e se perdem se o app for desinstalado. Ao se cadastrar, a conta anônima é vinculada à nova conta de e-mail e senha, e todos os dados já registrados são mantidos. | Decisão do grupo (10/11/2026); RF17, RF18 | UC15; `docs/mapeamento-dart-firestore.md`, seção 6 |
| RN20 | Nome de usuário e foto de perfil são opcionais, só existem para usuários cadastrados e não são mostrados a ninguém além do próprio usuário. A foto é reduzida no aparelho antes do envio. | Decisão do grupo (10/11/2026); RF20; RNF03 | UC18; campos `nomeUsuario` e `fotoPerfil` |
| RN21 | A recuperação de senha envia um link de redefinição ao e-mail informado. Por privacidade, o app mostra a mesma mensagem exista ou não uma conta com aquele e-mail. | Decisão do grupo (10/11/2026); RF19 | UC17 |

## 2. Diário, PHQ-9 e respiração

| ID | Descrição | Origem | Impacto |
|---|---|---|---|
| RN03 | Um registro de humor não pode ser editado. Para corrigir, o usuário exclui e cria outro. | `docs/requisitos.md`, seção 4 | Telas 02 e 03; `allow update: if false` |
| RN04 | Uma resposta do PHQ-9 não pode ser editada nem excluída individualmente. Só o Botão de Pânico remove esses dados. | `docs/requisitos.md`, seção 4 | Telas 05 e 06; Security Rules |
| RN06 | A nota do diário e as respostas do PHQ-9 vão para a nuvem já cifradas. | RF12 | Classe `Criptografia`; campos `notaCifrada` e `respostasCifradas` |
| RN10 | O nível de humor e o escore do PHQ-9 ficam sem cifra no banco, protegidos pelas Security Rules, porque o usuário os revisita no histórico e no gráfico. | Decisão do grupo (10/11/2026) | RF12; `docs/modelagem-firestore.md`, seção 9 |
| RN13 | A respiração guiada segue o padrão 4-7-8 (4s inspirar, 7s segurar, 8s expirar), que prevalece sobre a faixa "de 4 a 7 segundos por etapa" do estudo de caso. | RF05; decisão do grupo (10/11/2026) | Tela 04 |
| RN14 | O escore do PHQ-9 só é calculado e gravado quando as nove perguntas foram respondidas. | `docs/diagrama-classes.md` (`estaCompleta()`); RF07 | Telas 05 e 06 |
| RN16 | A nota do diário aceita até 10.000 caracteres. O limite existe só para proteger o banco e não restringe o que o usuário quer escrever; o contador de caracteres só aparece quando faltam menos de 500. | Decisão do grupo (10/11/2026); RF02 | Tela 02; `validar()`; Security Rules |
| RN17 | O PHQ-9 pode ser respondido uma vez a cada 7 dias. Antes disso, a tela informa a data da próxima aplicação, e o gráfico de evolução continua acessível a qualquer momento. | Decisão do grupo (10/11/2026); RF06, RF08 | Telas 05 e 06 |

## 3. Emergência, conexão e exclusão

| ID | Descrição | Origem | Impacto |
|---|---|---|---|
| RN05 | Nenhuma funcionalidade crítica depende de rede: o diário funciona offline e o CVV disca sem internet. | RF10, RF16, RNF07 | Persistência offline do Firestore; número do CVV embutido |
| RN07 | O Botão de Pânico exige confirmação em página inteira e apaga primeiro os dados locais, sem esperar resposta da nuvem. Para usuário cadastrado, a senha é pedida de novo antes de qualquer exclusão, como confirmação extra, e por isso o Botão de Pânico dele precisa de internet. A conta só é excluída depois que a nuvem confirma a exclusão dos dados. | RF13; `docs/justificativas.md`, seções 4 e 8 | Tela 09; ordem de exclusão (`docs/modelagem-firestore.md`, seção 8) |
| RN08 | O número do CVV é fixo e não pode ser alterado pelo usuário. | `docs/requisitos.md`, seção 4 | Classe `ContatoEmergencia`; fora do Firestore |
| RN09 | Um toque no botão do CVV abre a confirmação de chamada (Tela 07); a discagem para o 188 só acontece depois que o usuário confirma. | Decisão do grupo (10/11/2026); UC09; protótipo, Tela 07 | RF09 e F04 |
| RN12 | O app tem quatro telas principais: Diário de humor, Respiração Guiada, PHQ-9 e acesso ao CVV. As demais são telas secundárias, de confirmação ou de conta. | `docs/estudo-de-caso.md`, seção 7; decisão do grupo (10/11/2026) | `docs/escopo.md`, seção 4 |
| RN15 | Sem conexão, o app não bloqueia nenhuma tela: diário e PHQ-9 gravam no cache local e sincronizam quando a rede volta, com um aviso discreto ("Sem conexão. Seus registros serão sincronizados depois."). Login, cadastro e recuperação de senha precisam de internet e mostram "Sem conexão. Tente de novo quando estiver online.", sem perder o que foi digitado. Se o Botão de Pânico for acionado offline por um usuário sem cadastro, os dados locais são apagados na hora, a exclusão na nuvem acontece quando a conexão voltar e a conta anônima fica vazia até lá; o app avisa que a exclusão na nuvem termina quando houver conexão. | Projeto II, Q1 a) iv; RNF07; decisão do grupo (10/11/2026) | Todas as telas que gravam dados; telas de conta; `docs/eap.md`, pacote 1.6.2 |

## 4. Decisões de 21/11/2026

Regras definidas pelo grupo depois da auditoria do código de 19/11/2026 (decisões P2 a P5).

| ID | Descrição | Origem | Impacto |
|---|---|---|---|
| RN22 | O resultado do PHQ-9 usa as faixas padrão do instrumento: 0 a 4 mínima, 5 a 9 leve, 10 a 14 moderada, 15 a 19 moderadamente grave e 20 a 27 grave. A faixa aparece sem linguagem alarmista, junto do aviso de que o resultado não é um diagnóstico. Prevalece sobre o texto "leve a moderada" do protótipo da Tela 06. | Decisão do grupo (21/11/2026, P3); RF07 | Tela 06 |
| RN23 | Se a resposta da pergunta 9 do PHQ-9 (pensar em se ferir) for maior que zero, o resultado mostra um cartão de apoio com acesso direto à confirmação de chamada ao CVV (Tela 07). | Decisão do grupo (21/11/2026, P4); ampliação de escopo aprovada pelo grupo | Telas 06 e 07; F03, F04 |
| RN24 | Ao entrar numa conta existente enquanto há registros feitos sem cadastro, o app avisa que esses registros não vão para a conta e pede confirmação. Para guardá-los, o usuário deve criar uma conta em vez de entrar. | Decisão do grupo (21/11/2026, P5); RN19, RF19 | Tela de login; UC16 |
| RN25 | As Telas 01, 04 e 09 ficam como foram implementadas, e as diferenças em relação ao protótipo de alta fidelidade são decisão do grupo: na Início, o seletor de humor e os textos dos cards; na Tela 04, o título na barra superior e os textos do círculo; na Tela 09, o título "Botão de Pânico" e a senha pedida ao usuário cadastrado no lugar da caixa de confirmação. | Decisão do grupo (21/11/2026, P2); Q1 a) iii | Telas 01, 04 e 09 |
