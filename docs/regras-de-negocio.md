# Projeto Unidade II: Regras de Negócio

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 a) iv) e b) i)

| Campo | Preenchimento |
|---|---|
| Seção | Regras de negócio consolidadas (Q1 a) iv; Q1 b) i) |
| Autor desta seção | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | `docs/diagrama-casos-de-uso.md`, `docs/requisitos.md`, `docs/estudo-de-caso.md`, `docs/diagrama-classes.md`, `docs/modelagem-firestore.md`, `docs/eap.md` e o enunciado do Projeto II |

> **Aviso:** não há aditivo oficial de regras de negócio para este projeto. Este documento consolida as regras que já estavam nos documentos de `docs/` e as decisões tomadas pelo grupo em 10/11/2026.

A numeração continua a de `docs/diagrama-casos-de-uso.md`, para não existirem duas sequências de regras no projeto.

## 1. Conta, acesso e privacidade

| ID | Descrição | Origem | Impacto |
|---|---|---|---|
| RN01 | O uso sem cadastro é anônimo: o app não pede nenhum dado pessoal. O cadastro é opcional e pede só e-mail e senha. | RF11, RF17, RF18; Projeto II, observação 8 e Q1 a) ii | UC01, UC15; `docs/modelagem-firestore.md`, seção 1 |
| RN02 | Cada usuário só lê e grava os próprios dados, garantido pelas Security Rules do Firestore. | RNF03 | Security Rules (`docs/modelagem-firestore.md`, seção 7); controle de acesso da Q1 a) iv |
| RN11 | O app tem as telas de conta (login, cadastro, recuperação de senha e perfil). Elas não fazem parte do escopo de prototipação: não têm protótipo de baixa nem de alta fidelidade e ficam registradas apenas nos documentos. | Projeto II, Q1 e) i; decisão do grupo (10/11/2026) | `docs/escopo.md`, seção 4; `docs/eap.md`, pacote 1.3.1 |
| RN18 | No primeiro acesso, o app abre a tela de login com as opções "Entrar", "Criar conta", "Esqueci minha senha" e "Continuar sem cadastro". Nos acessos seguintes, abre direto no Início. O login e o cadastro também ficam disponíveis em Configurações. O botão do CVV aparece também na tela de login. | Decisão do grupo (10/11/2026); RF09; RNF01 | UC01, UC15, UC16; fluxo de navegação (Q1 b) v) |
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
| RN07 | O Botão de Pânico exige confirmação em página inteira e apaga primeiro os dados locais, sem esperar resposta da nuvem. Para usuário cadastrado, a exclusão da conta pede a senha de novo, como confirmação extra. | RF13; `docs/justificativas.md`, seções 4 e 8 | Tela 09; ordem de exclusão (`docs/modelagem-firestore.md`, seção 8) |
| RN08 | O número do CVV é fixo e não pode ser alterado pelo usuário. | `docs/requisitos.md`, seção 4 | Classe `ContatoEmergencia`; fora do Firestore |
| RN09 | Um toque no botão do CVV abre a confirmação de chamada (Tela 07); a discagem para o 188 só acontece depois que o usuário confirma. | Decisão do grupo (10/11/2026); UC09; protótipo, Tela 07 | RF09 e F04 |
| RN12 | O app tem quatro telas principais: Diário de humor, Respiração Guiada, PHQ-9 e acesso ao CVV. As demais são telas secundárias, de confirmação ou de conta. | `docs/estudo-de-caso.md`, seção 7; decisão do grupo (10/11/2026) | `docs/escopo.md`, seção 4 |
| RN15 | Sem conexão, o app não bloqueia nenhuma tela: diário e PHQ-9 gravam no cache local e sincronizam quando a rede volta, com um aviso discreto ("Sem conexão. Seus registros serão sincronizados depois."). Login, cadastro e recuperação de senha precisam de internet e mostram "Sem conexão. Tente de novo quando estiver online.", sem perder o que foi digitado. Se o Botão de Pânico for acionado offline, os dados locais são apagados na hora e a exclusão na nuvem acontece quando a conexão voltar. | Projeto II, Q1 a) iv; RNF07; decisão do grupo (10/11/2026) | Todas as telas que gravam dados; telas de conta; `docs/eap.md`, pacote 1.6.2 |
