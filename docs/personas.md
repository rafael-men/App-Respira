# Personas da Atividade 02: Pesquisa, Benchmark e Personas

Projeto Respira, aplicativo de saúde mental e apoio emocional
Disciplina: Programação para Dispositivos Móveis | Valor da atividade: 2,0 pontos (Personas: 0,50)

| Campo | Preenchimento |
|---|---|
| Seção | Personas (item 4 da Atividade 02) |
| Autores desta seção | Rafael Menezes Gonçalves (Persona 1) e Rene Mendonça Marinho (Persona 2) |
| Data | 08/09/2026 |

## Persona 1 — Marina Souza (uso emergencial/crise)

*Perfil/contexto:* 29 anos, paciente de CAPS em tratamento para transtorno de ansiedade há 8 meses. Mora sozinha, trabalha em horário comercial, tem um smartphone de entrada com plano de dados limitado.

*Objetivos:*
- Ter acesso rápido a ajuda humana quando uma crise de pânico começa.
- Conseguir se acalmar sozinha nos episódios mais leves, sem precisar sair de casa ou ligar para alguém.
- Manter continuidade do acompanhamento entre uma consulta e outra no CAPS.

*Necessidades:*
- Um canal de ajuda (CVV) acessível em segundos, mesmo sem internet.
- Uma técnica de regulação (respiração) que não exija leitura longa ou raciocínio complexo durante a crise.
- Registro de humor que ajude a levar informação organizada para a próxima consulta.

*Dores:*
- Já teve uma crise em que não conseguiu lembrar ou encontrar rapidamente o número do CVV.
- Segundo a pesquisa do projeto (docs/pesquisa.md), menos de 35% dos municípios brasileiros têm CAPS próprio, o que reforça sua dependência de um canal de apoio sempre disponível quando não pode se deslocar até uma consulta.
- Sente vergonha de expor que está mal perto de colegas de trabalho.
- Tem medo de que dados sobre sua saúde mental vazem ou sejam usados contra ela.

*Comportamentos:*
- Abre o celular já em estado de atenção reduzida, sem paciência para navegar em menus.
- Prefere usar o aplicativo sozinha, em silêncio, muitas vezes à noite.
- Evita aplicativos que pedem cadastro ou muitas etapas antes de entregar alguma utilidade.

*Relação com o aplicativo:* Usa o Respira principalmente em momentos de crise (engajamento emergencial), mas também mantém o diário de humor como rotina de manutenção entre atendimentos no CAPS. Para ela, o app é uma ponte de segurança até a rede de apoio profissional, nunca um substituto dela.

## Persona 2 — Lucas Andrade (uso diário/rotina)

*Perfil/contexto:* 21 anos, estudante universitário em período de provas frequentes, mora com os pais, usa o celular entre aulas e durante intervalos curtos. Nunca teve contato com um serviço de saúde mental.

*Objetivos:*
- Entender se o que sente (ansiedade antes de provas, oscilação de humor) tem nome e intensidade.
- Ter uma ferramenta rápida e discreta para usar entre uma aula e outra.
- Acompanhar sua evolução emocional ao longo do semestre.

*Necessidades:*
- Registro de humor em poucos toques, sem burocracia.
- Um instrumento de rastreio (PHQ-9) que traduza sensações difusas em algo mensurável.
- Uso discreto, que não chame atenção de colegas ao redor.

*Dores:*
- Tem receio de ser rotulado ou julgado se alguém descobrir que usa um app de saúde mental.
- Não sabe ao certo se o que sente é "só estresse de prova" ou algo que merece atenção.
- Pouco tempo livre — qualquer app que exija muitas etapas é abandonado rapidamente.
- Segundo a pesquisa do projeto (docs/pesquisa.md), 83,05% dos universitários brasileiros relatam dificuldades emocionais na graduação (dado da Andifes), o que confirma que Lucas representa um público amplo, não um caso isolado.

*Comportamentos:*
- Usa o app em sessões curtas e frequentes, muitas vezes escondido, entre uma atividade e outra.
- Responde ao questionário semanal aos poucos, aproveitando brechas da rotina.
- Valoriza ver gráficos de progresso como forma de entender a própria evolução.

*Relação com o aplicativo:* Uso predominantemente diário/rotineiro (diário de humor, respiração e PHQ-9 semanal), sem necessariamente ter usado o botão do CVV ainda. Para ele, o app é uma porta de entrada — o primeiro contato com a ideia de que aquilo que sente pode ser observado e cuidado.

## Persona prioritária: Marina Souza

A escolha por Marina se justifica pelo tipo de cenário que ela representa: uma pessoa em crise, com atenção reduzida, possivelmente sem internet, decidindo em segundos o que fazer. É esse cenário que exige mais do projeto tecnicamente e que tem maior peso humano caso o app falhe. Foi a partir dele que nasceram as decisões mais críticas do produto — o botão do CVV a um toque, o número em cache local, o funcionamento offline. Priorizar Marina no design significa garantir que a função mais importante do aplicativo funcione mesmo na pior condição possível. Se o projeto partisse primeiro de Lucas, o risco seria tratar o CVV como só mais uma funcionalidade entre outras, quando na prática é o motivo de existir do aplicativo nos momentos que mais importam. Essa priorização também é sustentada pelo benchmark (docs/benchmark.md): nenhuma das soluções analisadas oferece emergência de um toque de graça, o que confirma que esse é o maior risco do produto caso o Respira falhe em atender exatamente o cenário de Marina.