# Projeto Unidade II Modelagem do Banco de Dados no Firestore
 
Projeto Respira, aplicativo de saúde mental e apoio emocional
Disciplina Programação para Dispositivos Móveis  Projeto da Unidade II, Questão 01 b) iii) (parte de 2,0 pontos)
 
 Campo  Preenchimento 
------
 Seção  Modelagem do Banco de Dados, estrutura de coleções e documentos no Firebase (Q1 b) iii) 
 Autor desta seção  Rafael Menezes Gonçalves 
 Sprint  Sprint 2 (10112026 a 16112026) 
 Base  docsdiagrama-classes.md, docsdiagrama-casos-de-uso.md (regras RN01 a RN08), docsrequisitos.md (CRUD, seção 4) e docsescopo.md (escopo técnico) 
 
Este documento define como os dados do Respira ficam organizados no Cloud Firestore coleções, documentos, campos, tipos, consultas e regras de acesso. A correspondência campo a campo com as classes Dart está em docsmapeamento-dart-firestore.md (Q1 b) iv).
 
## 1. Decisões de modelagem
 
 Decisão  Motivo 
------
 Tudo fica abaixo de usuarios{uid}  O uid vem da conta anônima do Firebase Authentication (RF17). Agrupar por usuário permite que as Security Rules isolem cada pessoa com uma única regra (RN02, RNF03). 
 Diário e PHQ-9 em subcoleções  São listas que crescem com o tempo (composição 1 para 0.. no diagrama de classes). Em subcoleção, cada registro é um documento pequeno, consultável e excluível sozinho (RF04). 
 Configurações como campo de mapa no documento do usuário  A relação é 1 para 1 no diagrama de classes. Um mapa dentro de usuarios{uid} evita uma leitura extra ao abrir o app. 
 Número do CVV fora do banco  É constante no código (ContatoEmergencia) e precisa discar sem rede (RF10, RN08). 
 Nenhum dado pessoal  Não existe campo de nome, e-mail, telefone ou localização (RN01, RNF03). 
 Campos sensíveis cifrados no aparelho  Nota do diário e respostas do PHQ-9 chegam ao Firestore já cifradas (RF12, RN06). 
 Datas geradas no aparelho, não pelo servidor  Com persistência offline, um registro criado sem rede precisa da data na hora em que foi criado. A data do servidor só existiria depois da sincronização (RF16, RN05). 
 Nomes de coleção em snake_case e campos em camelCase  Coleções ficam legíveis em português; os campos seguem o mesmo nome dos atributos Dart, o que simplifica o mapeamento. 
 
## 2. Estrutura de coleções e documentos
 
@startuml
top to bottom direction
skinparam shadowing false

object "Cloud Firestore" as ROOT

object "coleção usuarios" as C1

object "documento {uid}" as D1 {
  anonimo
  criadoEm
  configuracoes
}

object "subcoleção registros_humor" as C2
object "subcoleção respostas_phq9" as C3

object "documento {id automático}" as D2 {
  humor
  notaCifrada
  criadoEm
}

object "documento {id automático}" as D3 {
  respostasCifradas
  escore
  respondidoEm
}

ROOT --> C1
C1 --> D1
D1 --> C2
D1 --> C3
C2 --> D2
C3 --> D3
@enduml

Usado o site para representação visual: PlantText
 
Em forma de caminho
 

usuarios{uid}
  ├─ registros_humor{registroId}
  └─ respostas_phq9{respostaId}

 
## 3. Documentos e campos
 
### 3.1 usuarios{uid}
 
 Campo  Tipo no Firestore  Obrigatório  Exemplo  Observação 
---------------
 (id do documento)  string  Sim  Xk2...9aQ  É o uid da conta anônima. Não é repetido como campo. 
 anonimo  boolean  Sim  true  Sempre true (RN01). 
 criadoEm  timestamp  Sim  2026-11-17T091200-0300  Data do primeiro acesso. 
 configuracoes  map  Sim  ver abaixo  Preferências do usuário. 
 configuracoes.temaEscuro  boolean  Sim  false  RF15. Padrão false. 
 configuracoes.notificacoesAtivas  boolean  Sim  false  RF14. Padrão false, para que nenhuma notificação apareça sem o usuário pedir. 
 
### 3.2 usuarios{uid}registros_humor{registroId}
 
 Campo  Tipo no Firestore  Obrigatório  Exemplo  Observação 
---------------
 (id do documento)  string  Sim  gerado pelo Firestore  Usado para excluir um registro (RF04). 
 humor  string  Sim  bem  Um dos cinco valores muitoMal, mal, neutro, bem, muitoBem (RF01). 
 notaCifrada  string ou null  Não  q8F...==  Nota opcional e curta (RF02), cifrada no aparelho. null quando não houver nota. 
 criadoEm  timestamp  Sim  2026-11-18T224000-0300  Data e hora do registro (RF01). 
 
### 3.3 usuarios{uid}respostas_phq9{respostaId}
 
 Campo  Tipo no Firestore  Obrigatório  Exemplo  Observação 
---------------
 (id do documento)  string  Sim  gerado pelo Firestore  Um documento por aplicação semanal. 
 respostasCifradas  string  Sim  Z1c...==  As nove respostas (0 a 3), cifradas no aparelho (RF06, RF12). 
 escore  number (inteiro)  Sim  11  Soma das respostas, de 0 a 27 (RF07). Usado no gráfico (RF08). 
 respondidoEm  timestamp  Sim  2026-11-23T200500-0300  Data da aplicação. 
 
## 4. Exemplo de documentos
 
json
 usuariosXk2...9aQ
{
  anonimo true,
  criadoEm 2026-11-17T091200-0300,
  configuracoes { temaEscuro true, notificacoesAtivas false }
}
 
 usuariosXk2...9aQregistros_humor7Hc...p2
{
  humor neutro,
  notaCifrada q8F...==,
  criadoEm 2026-11-18T224000-0300
}
 
 usuariosXk2...9aQrespostas_phq9Lm4...t9
{
  respostasCifradas Z1c...==,
  escore 11,
  respondidoEm 2026-11-23T200500-0300
}

 
Os valores de exemplo são fictícios. No Firestore, as datas são do tipo timestamp; aqui aparecem como texto só para leitura.
 
## 5. Operações (CRUD) por coleção
 
 Coleção  Criar  Ler  Atualizar  Excluir  Regra 
------------------
 usuarios{uid}  No primeiro acesso (UC01)  Ao abrir o app  Só configuracoes (UC10, UC11)  Só pelo Botão de Pânico (UC12)  RN01, RN02 
 registros_humor  UC02  UC03  Nunca  Individual (UC04) ou total (UC12)  RN03 
 respostas_phq9  UC06  UC08  Nunca  Só total, pelo Botão de Pânico (UC12)  RN04 
 
Esta tabela é a mesma de docsrequisitos.md, seção 4, aplicada às coleções.
 
## 6. Consultas
 
 Tela  Consulta  Índice 
---------
 Tela 03, histórico do diário  registros_humor ordenada por criadoEm, decrescente  Índice simples, criado automaticamente pelo Firestore 
 Tela 06, gráfico do PHQ-9  respostas_phq9 ordenada por respondidoEm, crescente  Índice simples, criado automaticamente pelo Firestore 
 Abertura do app  Leitura direta de usuarios{uid}  Não precisa de índice 
 
Nenhuma consulta filtra por mais de um campo, então o projeto não precisa de índice composto.
 
## 7. Regras de segurança (Security Rules)
 

rules_version = '2';
service cloud.firestore {
  match databases{database}documents {
 
    function dono(uid) {
      return request.auth != null && request.auth.uid == uid;
    }
 
    match usuarios{uid} {
      allow read, delete if dono(uid);
      allow create if dono(uid)
        && request.resource.data.anonimo == true
        && request.resource.data.configuracoes.temaEscuro is bool
        && request.resource.data.configuracoes.notificacoesAtivas is bool;
      allow update if dono(uid)
        && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['configuracoes']);
 
      match registros_humor{registroId} {
        allow read, delete if dono(uid);
        allow create if dono(uid)
          && request.resource.data.humor in ['muitoMal', 'mal', 'neutro', 'bem', 'muitoBem']
          && request.resource.data.criadoEm is timestamp
          && (request.resource.data.notaCifrada == null
               (request.resource.data.notaCifrada is string
                  && request.resource.data.notaCifrada.size() = 2000));
        allow update if false;
      }
 
      match respostas_phq9{respostaId} {
        allow read, delete if dono(uid);
        allow create if dono(uid)
          && request.resource.data.respostasCifradas is string
          && request.resource.data.escore is int
          && request.resource.data.escore = 0
          && request.resource.data.escore = 27
          && request.resource.data.respondidoEm is timestamp;
        allow update if false;
      }
    }
 
    match {documento=} {
      allow read, write if false;
    }
  }
}

 
 Trecho  O que garante 
------
 dono(uid)  Só a própria conta anônima lê e grava os seus dados (RN02, RNF03). 
 update no usuário restrito a configuracoes  Não dá para alterar anonimo nem criadoEm depois de criados. 
 allow update if false no diário e no PHQ-9  Registros e respostas não podem ser editados (RN03, RN04). 
 Validação de humor, escore e datas  O banco recusa dados fora do formato, mesmo que o app tenha erro (validações de Q1 a) iv). 
 Regra final {documento=}  Qualquer caminho fora de usuarios{uid} é negado. 
 
A regra de delete em respostas_phq9 existe só para que o Botão de Pânico consiga apagar tudo. O app não oferece exclusão individual de respostas (RN04); essa restrição fica na interface, porque as Security Rules não distinguem de qual tela veio o pedido.
 
## 8. Exclusão total pelo Botão de Pânico
 
O Firestore não apaga subcoleções quando o documento pai é apagado. Por isso o Botão de Pânico (UC12, RF13) segue esta ordem
 
1. Apaga os dados locais do aparelho, sem esperar a nuvem (RN07).
2. Apaga todos os documentos de registros_humor e respostas_phq9 do usuário.
3. Apaga o documento usuarios{uid}.
4. Exclui a conta anônima no Firebase Authentication.
 
Se não houver internet, os passos 2 e 3 ficam na fila do Firestore e são enviados quando a conexão voltar. O passo 4 depende de rede; até lá, a conta fica sem dados.
 
## 9. Ponto de atenção sobre criptografia
 
O diagrama de classes cifra a nota do diário e as respostas do PHQ-9, mas mantém humor e escore legíveis no banco. Esses dois campos ficam protegidos pelas Security Rules, mas não estão cifrados. Como as consultas da seção 6 ordenam só por data, o grupo pode cifrar também humor e escore sem perder nenhuma consulta, aplicando o RF12 de forma mais rígida. Essa decisão precisa ser tomada no checkpoint e refletida também em docsdiagrama-classes.md e em docsmapeamento-dart-firestore.md.
 