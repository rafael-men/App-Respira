import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../auth/data/auth_repository.dart';
import '../data/preferencias_usuario.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/opcao_resposta.dart';
import 'home_page.dart';

/// Apresentação do app 
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.authRepository,
    required this.preferencias,
  });

  final AuthRepository authRepository;
  final PreferenciasUsuario preferencias;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _Pergunta {
  const _Pergunta(this.titulo, this.opcoes);

  final String titulo;
  final List<String> opcoes;
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _totalApresentacao = 3;
  static const _larguraMaxima = 480.0;

  static const _perguntas = [
    _Pergunta('O que mais te traz ao Respira?', [
      'Preciso de alívio em momentos difíceis',
      'Quero acompanhar meu humor no dia a dia',
      'Quero as duas coisas',
    ]),
    _Pergunta('Com que frequência você quer registrar como se sente?', [
      'Todos os dias',
      'Algumas vezes por semana',
      'Quando eu sentir vontade',
    ]),
    _Pergunta('Quer receber lembretes gentis?', [
      'Sim, de vez em quando',
      'Não por enquanto',
    ]),
  ];

  final _controller = PageController();
  final List<int?> _respostas = List.filled(_perguntas.length, null);
  int _pagina = 0;

  int get _total => _totalApresentacao + _perguntas.length;

  bool get _ehUltima => _pagina == _total - 1;

  bool get _podeAvancar {
    if (_pagina < _totalApresentacao) return true;
    return _respostas[_pagina - _totalApresentacao] != null;
  }

  Duration _tempo(int milissegundos) {
    return MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : Duration(milliseconds: milissegundos);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _avancar() {
    if (_ehUltima) {
      _concluir();
      return;
    }
    _controller.nextPage(duration: _tempo(320), curve: Curves.easeOutCubic);
  }

  void _voltar() {
    _controller.previousPage(duration: _tempo(320), curve: Curves.easeOutCubic);
  }

  void _selecionar(int indicePergunta, int indiceOpcao) {
    setState(() => _respostas[indicePergunta] = indiceOpcao);
  }

  void _concluir() {
    final p = widget.preferencias;

    final objetivo = _respostas[0];
    if (objetivo != null) {
      p.objetivo = ObjetivoUso.values[objetivo];
    }

    final frequencia = _respostas[1];
    if (frequencia != null) {
      p.frequencia = FrequenciaRegistro.values[frequencia];
    }

    final lembretes = _respostas[2];
    if (lembretes != null) {
      p.receberLembretes = lembretes == 0;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomePage(authRepository: widget.authRepository),
      ),
      (_) => false,
    );
  }

  Widget _pagina_(Widget conteudo, {bool centralizar = true}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: centralizar
                ? Center(child: conteudo)
                : Align(alignment: Alignment.topLeft, child: conteudo),
          ),
        );
      },
    );
  }

  List<Widget> _paginas(double tamanhoIlustracao) {
    return [
      _pagina_(
        OnboardingSlide(
          ilustracao: ClipOval(
            child: Image.asset(
              'assets/respira-icon.png',
              width: tamanhoIlustracao,
              height: tamanhoIlustracao,
              fit: BoxFit.cover,
            ),
          ),
          titulo: 'Bem-vindo ao Respira',
          texto:
              'Um espaço seguro para cuidar da sua saúde mental, sem julgamentos.',
        ),
      ),
      _pagina_(
        OnboardingSlide(
          ilustracao: _IconeIlustracao(Icons.air, tamanhoIlustracao),
          titulo: 'Alívio no momento certo',
          texto:
              'Respire com o guia e tenha o CVV (188) a apenas um toque, para emergências.',
        ),
      ),
      _pagina_(
        OnboardingSlide(
          ilustracao: _IconeIlustracao(
            Icons.insights_outlined,
            tamanhoIlustracao,
          ),
          titulo: 'Acompanhe sua evolução',
          texto:
              'Registre seu humor e responda o quesrionário toda semana.',
        ),
      ),
      for (var i = 0; i < _perguntas.length; i++)
        _pagina_(_conteudoPergunta(i), centralizar: false),
    ];
  }

  Widget _conteudoPergunta(int indice) {
    final pergunta = _perguntas[indice];
    final selecionada = _respostas[indice];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          'Pergunta ${indice + 1} de ${_perguntas.length}',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Text(
          pergunta.titulo,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.purple900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < pergunta.opcoes.length; i++) ...[
          OpcaoResposta(
            texto: pergunta.opcoes[i],
            selecionada: selecionada == i,
            onTap: () => _selecionar(indice, i),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoIlustracao = (MediaQuery.sizeOf(context).shortestSide * 0.35)
        .clamp(96.0, 140.0)
        .toDouble();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.purple900,
        leading: _pagina > 0
            ? IconButton(
                tooltip: 'Voltar',
                icon: const Icon(Icons.arrow_back),
                onPressed: _voltar,
              )
            : null,
        actions: [TextButton(onPressed: _concluir, child: const Text('Pular'))],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _larguraMaxima),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(end: (_pagina + 1) / _total),
                    duration: _tempo(400),
                    curve: Curves.easeOut,
                    builder: (context, valor, _) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: valor,
                        minHeight: 6,
                        color: AppColors.purple700,
                        backgroundColor: AppColors.purple500.withValues(
                          alpha: 0.15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (i) => setState(() => _pagina = i),
                      children: _paginas(tamanhoIlustracao),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    label: _ehUltima ? 'Começar' : 'Continuar',
                    onPressed: _podeAvancar ? _avancar : null,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconeIlustracao extends StatelessWidget {
  const _IconeIlustracao(this.icone, this.tamanho);

  final IconData icone;
  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icone, size: tamanho * 0.47, color: AppColors.purple700),
    );
  }
}
