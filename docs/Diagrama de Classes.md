diagrama-classes.md
 
# Projeto Unidade II: Diagrama de Classes (Modelos de Domínio)
 
_Projeto Respira, aplicativo de saúde mental e apoio emocional_
Disciplina: Programação para Dispositivos Móveis | Projeto da Unidade II, Questão 01 b) ii) (parte de 2,0 pontos)
 
| Campo | Preenchimento |
|---|---|
| Seção | Diagrama de Classes, modelos de domínio (Q1 b) ii) |
| Autor desta seção | Murilo Pedral Mota |
| Sprint | Sprint 2 (10/11/2026 a 16/11/2026) |
| Base | `docs/requisitos.md` (RF01 a RF16 e CRUD), `docs/diagrama-casos-de-uso.md`, `docs/escopo.md` e a decisão por Firebase da Sprint 1 |
 
O diagrama mostra as principais entidades do domínio do Respira, com atributos, métodos principais e relacionamentos. As classes seguem a tabela de CRUD de `docs/requisitos.md`, seção 4: cada informação que o usuário cria, consulta, atualiza ou exclui virou uma classe. Os métodos `toMap()` e `fromMap()` indicam onde cada classe se converte em documento do Firestore; o mapeamento completo fica na modelagem do banco (Q1 b) iv).
 
## 1. Diagrama

    class Usuario {
        -String uid
        -bool anonimo
        -DateTime criadoEm
        +entrarAnonimamente() Future~Usuario~$
        +apagarTodosOsDados() Future~void~
        +toMap() Map~String, dynamic~
        +fromMap(String uid, Map~String, dynamic~ dados) Usuario$
    }
 
    class RegistroHumor {
        -String id
        -NivelHumor humor
        -String? nota
        -DateTime criadoEm
        +validar() bool
        +toMap() Map~String, dynamic~
        +fromMap(String id, Map~String, dynamic~ dados) RegistroHumor$
    }
 
    class NivelHumor {
        <<enumeration>>
        muitoMal
        mal
        neutro
        bem
        muitoBem
    }
 
    class RespostaPHQ9 {
        -String id
        -List~int~ respostas
        -int escore
        -DateTime respondidoEm
        +responder(int pergunta, int valor) void
        +estaCompleta() bool
        +calcularEscore() int
        +toMap() Map~String, dynamic~
        +fromMap(String id, Map~String, dynamic~ dados) RespostaPHQ9$
    }
 
    class Configuracoes {
        -bool temaEscuro
        -bool notificacoesAtivas
        +alternarTema() void
        +alternarNotificacoes() void
        +redefinir() void
        +toMap() Map~String, dynamic~
        +fromMap(Map~String, dynamic~ dados) Configuracoes$
    }
 
    class ContatoEmergencia {
        <<constante>>
        +String nome = "CVV"
        +String numero = "188"
        +ligar() Future~void~
    }
 
    class Criptografia {
        <<serviço>>
        +cifrar(String texto) String
        +decifrar(String textoCifrado) String
    }
 
    Usuario "1" *-- "0..*" RegistroHumor : registra
    Usuario "1" *-- "0..*" RespostaPHQ9 : responde
    Usuario "1" *-- "1" Configuracoes : possui
    RegistroHumor --> NivelHumor : classifica
    RegistroHumor ..> Criptografia : nota cifrada
    RespostaPHQ9 ..> Criptografia : respostas cifradas
    Usuario ..> ContatoEmergencia : aciona

Representação Visual Feita com o site: PlantText

## 2. Descrição das classes
 
| Classe | Responsabilidade | Requisitos |
|---|---|---|
| `Usuario` | Representa a conta anônima criada no Firebase Authentication. Guarda só o `uid` e a data de criação, sem nome, e-mail ou telefone. `apagarTodosOsDados()` implementa o Botão de Pânico. | F06, F08, RF11, RF13, RF17 |
| `RegistroHumor` | Um registro do diário, com o nível de humor, a nota opcional e a data e hora. Não tem método de edição, porque o registro não pode ser alterado depois de salvo. | F01, RF01 a RF04 |
| `NivelHumor` | As cinco opções de humor exibidas como emojis, de muito mal a muito bem. | RF01 |
| `RespostaPHQ9` | Uma aplicação semanal do PHQ-9, com as nove respostas, o escore calculado e a data. Não tem método de edição nem de exclusão individual. | F03, RF06, RF07, RF08 |
| `Configuracoes` | Preferências de tema e de notificações. `redefinir()` volta ao padrão, no lugar de uma exclusão. | RF14, RF15 |
| `ContatoEmergencia` | O número do CVV, fixo no código. Não é gravado no Firestore e não depende de rede. | F04, RF09, RF10 |
| `Criptografia` | Cifra e decifra a nota do diário e as respostas do PHQ-9 no aparelho, antes do envio ao Firestore. | F07, RF12 |
 
## 3. Atributos e métodos principais
 
| Classe | Membro | Detalhe |
|---|---|---|
| `Usuario` | `entrarAnonimamente()` | Método estático. Reaproveita a sessão se já existir; senão, cria a conta anônima. |
| `Usuario` | `apagarTodosOsDados()` | Apaga primeiro o cache local, depois os documentos do usuário no Firestore e, por fim, a conta anônima. |
| `RegistroHumor` | `nota` | Opcional (`String?`) e curta (RF02). Vai cifrada para o Firestore. |
| `RegistroHumor` | `validar()` | Confere se o humor foi escolhido e se a nota respeita o tamanho máximo. |
| `RespostaPHQ9` | `respostas` | Lista com as nove respostas, uma por pergunta, na escala do instrumento (0 a 3). Vai cifrada para o Firestore. |
| `RespostaPHQ9` | `estaCompleta()` | Só permite calcular o escore quando as nove perguntas foram respondidas. |
| `RespostaPHQ9` | `calcularEscore()` | Soma as nove respostas (RF07). O escore é usado no gráfico de evolução (RF08). |
| `ContatoEmergencia` | `ligar()` | Abre a discagem nativa para o 188, sem acesso à internet. |
 
## 4. Relacionamentos
 
| Relação | Tipo | Multiplicidade | Significado |
|---|---|---|---|
| `Usuario` → `RegistroHumor` | Composição | 1 para 0..* | Os registros pertencem ao usuário e são apagados com ele no Botão de Pânico. |
| `Usuario` → `RespostaPHQ9` | Composição | 1 para 0..* | As respostas pertencem ao usuário e só são removidas com ele. |
| `Usuario` → `Configuracoes` | Composição | 1 para 1 | Cada usuário tem um único conjunto de preferências. |
| `RegistroHumor` → `NivelHumor` | Associação | 1 para 1 | Cada registro tem exatamente um nível de humor. |
| `RegistroHumor`, `RespostaPHQ9` → `Criptografia` | Dependência | — | Usam o serviço para cifrar os dados sensíveis. |
| `Usuario` → `ContatoEmergencia` | Dependência | — | O usuário aciona o CVV; o contato não pertence a ele e não é gravado. |
 
A composição representa a regra do Botão de Pânico (RF13): quando o `Usuario` é apagado, tudo o que é dele é apagado junto.