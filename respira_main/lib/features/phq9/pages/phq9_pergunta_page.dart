import 'package:flutter/material.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/respira_app_bar.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../../main/widgets/opcao_resposta.dart';
import '../data/phq9_repository.dart';
import '../domain/perguntas_phq9.dart';
import '../domain/resposta_phq9.dart';
import 'phq9_resultado_page.dart';

/// Tela 05: questionário PHQ-9, uma pergunta por vez (F03, RF06, RN14, RN17).
///
/// Ao abrir, confere a última aplicação: antes de 7 dias, mostra a data da
/// próxima e o acesso à evolução. No fim, grava a resposta e troca esta tela
/// pela Tela 06.
class Phq9PerguntaPage extends StatefulWidget {
  const Phq9PerguntaPage({super.key});

  @override
  State<Phq9PerguntaPage> createState() => _Phq9PerguntaPageState();
}

/// Data no formato dd/mm, usada na mensagem da RN17.
String diaMesPhq9(DateTime data) {
  String doisDigitos(int n) => n.toString().padLeft(2, '0');
  return '${doisDigitos(data.day)}/${doisDigitos(data.month)}';
}

String mensagemIntervaloPhq9(DateTime proximaAplicacao) =>
    'Você respondeu o PHQ-9 recentemente. A próxima aplicação fica '
    'disponível em ${diaMesPhq9(proximaAplicacao)}.';

class _Phq9PerguntaPageState extends State<Phq9PerguntaPage> {
  final _resposta = RespostaPHQ9.nova();
  bool _iniciado = false;
  bool _carregando = true;
  bool _enviando = false;
  DateTime? _proximaAplicacao;
  String? _erro;
  int _indice = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_iniciado) {
      _iniciado = true;
      _carregar();
    }
  }

  Future<void> _carregar() async {
    final phq9 = DependenciasScope.of(context).phq9;
    try {
      final ultima = await phq9.ultimaAplicacao();
      if (!mounted) return;
      setState(() {
        if (!RespostaPHQ9.podeResponder(ultima)) {
          _proximaAplicacao = RespostaPHQ9.proximaAplicacao(ultima!);
        }
        _carregando = false;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      // Sem a data, o questionário segue; o registro confere o intervalo.
      setState(() {
        _erro = e is AuthException
            ? e.message
            : 'Não foi possível conferir a última aplicação agora. '
                'Você pode responder mesmo assim.';
        _carregando = false;
      });
    }
  }

  int? get _respostaAtual => _resposta.respostas[_indice];

  bool get _ultimaPergunta => _indice == RespostaPHQ9.totalPerguntas - 1;

  void _escolher(int valor) {
    setState(() => _resposta.responder(_indice, valor));
  }

  void _voltarPergunta() {
    if (_indice > 0 && !_enviando) {
      setState(() {
        _indice--;
        _erro = null;
      });
    }
  }

  Future<void> _avancar() async {
    if (!_ultimaPergunta) {
      setState(() {
        _indice++;
        _erro = null;
      });
      return;
    }

    final phq9 = DependenciasScope.of(context).phq9;
    final navegador = Navigator.of(context);
    setState(() {
      _enviando = true;
      _erro = null;
    });
    try {
      await phq9.registrar(_resposta);
      if (!mounted) return;
      navegador.pushReplacement(
        MaterialPageRoute(
          builder: (_) => Phq9ResultadoPage(resposta: _resposta),
        ),
      );
    } on Phq9ForaDoIntervaloException catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = mensagemIntervaloPhq9(e.proximaAplicacao);
        _enviando = false;
      });
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.message;
        _enviando = false;
      });
    }
  }

  void _verEvolucao() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Phq9ResultadoPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emQuestionario = !_carregando && _proximaAplicacao == null;

    return PopScope(
      // No questionário, a seta e o voltar do aparelho voltam à pergunta
      // anterior, mantendo a resposta; na primeira, saem da tela.
      canPop: !emQuestionario || (_indice == 0 && !_enviando),
      onPopInvokedWithResult: (saiu, _) {
        if (!saiu && emQuestionario) _voltarPergunta();
      },
      child: Scaffold(
        appBar: const RespiraAppBar(titulo: 'PHQ-9'),
        body: SafeArea(
          child: _carregando
              ? const Center(child: CircularProgressIndicator())
              : _proximaAplicacao != null
                  ? _AvisoIntervalo(
                      mensagem: mensagemIntervaloPhq9(_proximaAplicacao!),
                      onVerEvolucao: _verEvolucao,
                    )
                  : _questionario(),
        ),
      ),
    );
  }

  Widget _questionario() {
    final numero = _indice + 1;
    const total = RespostaPHQ9.totalPerguntas;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: numero / total,
                    minHeight: 6,
                    color: AppColors.purple700,
                    backgroundColor: AppColors.purple500.withValues(alpha: 0.15),
                    semanticsLabel: 'Progresso do questionário',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pergunta $numero de $total',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  PerguntasPhq9.textoCompleto(_indice),
                  style: const TextStyle(
                    color: AppColors.purple900,
                    fontFamily: AppTheme.fonteTitulos,
                    fontSize: 19,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                for (final opcao in PerguntasPhq9.opcoes) ...[
                  OpcaoResposta(
                    texto: opcao.texto,
                    selecionada: _respostaAtual == opcao.valor,
                    onTap: () => _escolher(opcao.valor),
                  ),
                  const SizedBox(height: 10),
                ],
                if (_erro != null) ...[
                  const SizedBox(height: 8),
                  MensagemErro(mensagem: _erro!),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: GradientButton(
            label: _ultimaPergunta ? 'Ver resultado' : 'Próxima',
            carregando: _enviando,
            onPressed: _respostaAtual == null ? null : _avancar,
          ),
        ),
      ],
    );
  }
}

/// Mostrado quando ainda não passaram 7 dias desde a última aplicação (RN17).
class _AvisoIntervalo extends StatelessWidget {
  const _AvisoIntervalo({required this.mensagem, required this.onVerEvolucao});

  final String mensagem;
  final VoidCallback onVerEvolucao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.event_available_outlined,
            size: 48,
            color: AppColors.purple700,
          ),
          const SizedBox(height: 16),
          Text(
            mensagem,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          GradientButton(label: 'Ver minha evolução', onPressed: onVerEvolucao),
        ],
      ),
    );
  }
}
