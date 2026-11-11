# Projeto Unidade II: Estrutura Analítica do Projeto (EAP) Simplificada

_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 d) ii) (parte de 1,0 ponto)

| Campo | Preenchimento |
|---|---|
| Seção | Estrutura Analítica do Projeto simplificada (Q1 d) ii) |
| Autor desta seção | Franck Patrick Hora Vasconcelos |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | `docs/escopo.md`, `docs/requisitos.md`, `docs/justificativas.md`, `docs/prototipoAltaFidelidade.pdf` e o enunciado do Projeto II |

A EAP decompõe o escopo definido em `docs/escopo.md` em pacotes de trabalho entregáveis. Cada pacote está ligado a uma funcionalidade (F), a um requisito (RF/RNF) ou a um item do Projeto II, para que nada seja feito sem origem documentada. A distribuição dos pacotes por integrante e por sprint está em `docs/sprints.md`.

## 1. Diagrama da EAP

@startwbs
* 1. App Respira (Unidade II)

** 1.1 Gerenciamento
*** 1.1.1 Escopo
*** 1.1.2 EAP
*** 1.1.3 Planejamento em sprints
*** 1.1.4 Checkpoints semanais
*** 1.1.5 README e CHANGELOG

** 1.2 Documentação e modelagem
*** 1.2.1 Endosso do Firebase nos docs
*** 1.2.2 Diagrama de Casos de Uso
*** 1.2.3 Diagrama de Classes
*** 1.2.4 Modelagem do Firestore
*** 1.2.5 Mapeamento Dart → Firestore
*** 1.2.6 Fluxo de navegação real
*** 1.2.7 Registro de uso de IA

** 1.3 Prototipação
*** 1.3.1 Telas de conta (sem protótipo)
*** 1.3.2 Revisão do fluxo de navegação

** 1.4 Infraestrutura Firebase
*** 1.4.1 Projeto Firebase e FlutterFire
*** 1.4.2 Autenticação (anônima e e-mail/senha)
*** 1.4.3 Firestore com persistência offline
*** 1.4.4 Security Rules
*** 1.4.5 Criptografia no cliente

** 1.5 Funcionalidades
*** 1.5.1 Base: tema, componentes, AppBar com SOS
*** 1.5.2 Início
*** 1.5.3 Diário de humor
*** 1.5.4 Respiração 4-7-8
*** 1.5.5 PHQ-9 e gráfico
*** 1.5.6 CVV
*** 1.5.7 Configurações
*** 1.5.8 Botão de Pânico
*** 1.5.9 Notificações
*** 1.5.10 Tema escuro
*** 1.5.11 Conta e perfil

** 1.6 Qualidade
*** 1.6.1 Validações e controle de acesso
*** 1.6.2 Falhas de conexão
*** 1.6.3 Teste em Android real

** 1.7 Entrega
*** 1.7.1 Apresentação e defesa oral
*** 1.7.2 Link do repositório no Teams
@endwbs

Diagrama gerado no [PlantText](https://www.planttext.com/). Versão renderizada: [`docs/eap.pdf`](eap.pdf).

## 2. Dicionário da EAP

| Código | Pacote de trabalho | Entregável | Origem |
|---|---|---|---|
| **1.1** | **Gerenciamento** | | |
| 1.1.1 | Escopo | `docs/escopo.md` | Q1 d) i |
| 1.1.2 | EAP | `docs/eap.md` (este documento) | Q1 d) ii |
| 1.1.3 | Planejamento em sprints | `docs/sprints.md` | Q1 d) iii |
| 1.1.4 | Checkpoints semanais | Revisão de cada sprint registrada no README | Q1 c) iii; observação 1 |
| 1.1.5 | README e CHANGELOG | Responsabilidades reais e histórico atualizados a cada entrega | Q1 c) ii |
| **1.2** | **Documentação e modelagem** | | |
| 1.2.1 | Endosso do Firebase nos documentos existentes | Estudo de caso, pesquisa, personas, benchmark, requisitos (RF17) e justificativas, incluindo a seção 8 (Arquitetura do sistema), atualizados | Q1 a) ii |
| 1.2.2 | Diagrama de Casos de Uso | Diagrama atualizado com as regras de negócio (`docs/regras-de-negocio.md`) | Q1 b) i |
| 1.2.3 | Diagrama de Classes | Entidades de domínio com atributos, métodos e relacionamentos | Q1 b) ii |
| 1.2.4 | Modelagem do Firestore | Estrutura de coleções e documentos | Q1 b) iii |
| 1.2.5 | Mapeamento Dart → Firestore | Correspondência entre classes Dart e documentos | Q1 b) iv |
| 1.2.6 | Fluxo de navegação real | Diagrama de como as telas se conectam no app implementado | Q1 b) v |
| 1.2.7 | Registro de uso de IA | `docs/uso-de-ia.md` com prompts, erros, soluções e justificativa das bibliotecas | Q1 b) vi; observação 7 |
| **1.3** | **Prototipação** | | |
| 1.3.1 | Telas de conta (sem protótipo) | Login, cadastro, recuperação de senha e perfil registrados nos documentos. Essas telas ficam fora do escopo de prototipação | Q1 e) i; RF18 a RF20; RN11 |
| 1.3.2 | Revisão do fluxo de navegação | Fluxo do protótipo com a tela de login indicada como ponto de entrada no primeiro acesso | Q1 e) iv; RN18 |
| **1.4** | **Infraestrutura Firebase** | | |
| 1.4.1 | Projeto Firebase e FlutterFire | App Flutter conectado ao projeto Firebase | Observação 8 |
| 1.4.2 | Autenticação (anônima e e-mail/senha) | Uso sem cadastro pelo provedor anônimo; cadastro, login e recuperação de senha por e-mail e senha; vinculação da conta anônima à cadastrada | F06; F11; RF11; RF17 a RF19 |
| 1.4.3 | Firestore com persistência offline | Leitura e escrita funcionando sem rede | F05; RF16; RNF06; RNF07 |
| 1.4.4 | Security Rules | Acesso restrito ao próprio `uid` | RNF03; Q1 a) iv |
| 1.4.5 | Criptografia no cliente | Nota do diário e respostas do PHQ-9 cifradas antes do envio | F07; RF12 |
| **1.5** | **Funcionalidades** | | |
| 1.5.1 | Base visual | Tokens de cor e tipografia, componentes reutilizáveis, AppBar com botão SOS | `docs/justificativas.md`, seções 1, 2 e 5; RF09 |
| 1.5.2 | Início | Tela 01 com os quatro cards | `docs/justificativas.md`, seção 3; RNF01 |
| 1.5.3 | Diário de humor | Telas 02 e 03; criar, listar e excluir registro | F01; RF01 a RF04 |
| 1.5.4 | Respiração 4-7-8 | Tela 04 com animação automática | F02; RF05; RNF04 |
| 1.5.5 | PHQ-9 e gráfico | Telas 05 e 06; escore e gráfico de evolução | F03; RF06 a RF08 |
| 1.5.6 | CVV | Tela 07; discagem do 188 com número embutido | F04; RF09; RF10 |
| 1.5.7 | Configurações | Tela 08; tema e notificações gravados no Firestore | RF14; RF15 |
| 1.5.8 | Botão de Pânico | Tela 09; exclusão local, no Firestore e da conta (anônima ou cadastrada) | F08; RF13 |
| 1.5.9 | Notificações | Lembretes opcionais e não invasivos | F09; RF14 |
| 1.5.10 | Tema escuro | Variante escura fiel ao protótipo | F10; RF15 |
| 1.5.11 | Conta e perfil | Telas de login, cadastro, recuperação de senha e perfil (nome de usuário e foto opcionais) | F11; RF18 a RF20 |
| **1.6** | **Qualidade** | | |
| 1.6.1 | Validações e controle de acesso | Entradas validadas e Security Rules testadas | Q1 a) iv; RNF03 |
| 1.6.2 | Falhas de conexão | Mensagens não alarmistas e operação offline sem travar a tela | Q1 a) iv; RNF07 |
| 1.6.3 | Teste em Android real | Execução em aparelho de entrada registrada | RNF05; RNF08; observação 6 |
| **1.7** | **Entrega** | | |
| 1.7.1 | Apresentação e defesa oral | Slides e roteiro para 24/11/2026 e 01/12/2026 | Medida de Eficiência; observação 9 |
| 1.7.2 | Link do repositório no Teams | Link postado no espaço da atividade, dentro do prazo | Observações 3 a 5 |

## 3. Observações

- A EAP é simplificada, como pede o Projeto II: vai até o nível de pacote de trabalho, sem detalhar tarefas internas. As tarefas e os responsáveis ficam em `docs/sprints.md`.
- O pacote 1.3.1 existe porque o Projeto II pede a tela de login (Q1 e) i), enquanto o RF11 proíbe cadastro obrigatório. A solução é um cadastro opcional com e-mail e senha (F11): quem não quiser se cadastrar continua sem cadastro, de forma anônima (RF17). As telas de conta ficam fora do escopo de prototipação e são registradas apenas nos documentos (RN11).
- O número do CVV não aparece em 1.4 de propósito: ele não depende do Firebase (RF10).

---
