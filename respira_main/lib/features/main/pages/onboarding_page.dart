import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/respira_app_bar.dart';
import '../../auth/data/auth_repository.dart';
import '../../configuracoes/domain/configuracoes.dart';
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

  static const _indiceTema = 0;
  static const _indiceLembretes = 1;
  static const _perguntas = [
    _Pergunta('Qual tema você prefere?', ['Claro', 'Escuro']),
    _Pergunta('Quer receber um lembrete diário para registrar como se sente?', [
      'Ativar lembretes',
      'Agora não',
    ]),
  ];

  final _controller = PageController();
  final List<int?> _respostas = List.filled(_perguntas.length, null);
  int _pagina = 0;
  bool _concluindo = false;

  bool? get _temaEscuro => switch (_respostas[_indiceTema]) {
    0 => false,
    1 => true,
    _ => null,
  };

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

  Future<void> _concluir({bool configurarLembretes = true}) async {
    if (_concluindo) return;
    setState(() => _concluindo = true);

    final mensagem = await _salvarEscolhas(configurarLembretes);
    final preferencias = widget.preferencias;
    preferencias.onboardingConcluido = true;
    await preferencias.salvar();

    if (!mounted) return;
    if (mensagem != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(mensagem)));
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomePage(authRepository: widget.authRepository),
      ),
      (_) => false,
    );
  }

  Future<String?> _salvarEscolhas(bool configurarLembretes) async {
    final temaEscuro = _temaEscuro;
    final lembretes = configurarLembretes ? _respostas[_indiceLembretes] : null;
    if (temaEscuro == null && lembretes == null) return null;

    final deps = DependenciasScope.of(context);
    var novoAgendamento = false;
    try {
      final usuario = await deps.usuarios.observarUsuario().first.timeout(
        const Duration(seconds: 5),
      );
      if (!mounted) return null;
      final atual = usuario?.configuracoes ?? Configuracoes();
      var notificacoesAtivas = atual.notificacoesAtivas;
      if (lembretes != null) {
        notificacoesAtivas = lembretes == 0 && await deps.lembretes.ativar();
        novoAgendamento = notificacoesAtivas && !atual.notificacoesAtivas;
        if (!notificacoesAtivas && atual.notificacoesAtivas) {
          await deps.lembretes.desativar();
        }
      }
      await deps.usuarios.salvarConfiguracoes(
        Configuracoes(
          temaEscuro: temaEscuro ?? atual.temaEscuro,
          notificacoesAtivas: notificacoesAtivas,
        ),
      );
      if (lembretes == 0 && !notificacoesAtivas) {
        return kIsWeb
            ? 'Os lembretes estão disponíveis no aplicativo para celular.'
            : 'Os lembretes ficaram desativados. Você pode tentar ativá-los em Configurações.';
      }
      return null;
    } catch (_) {
      if (novoAgendamento) await deps.lembretes.desativar();
      return 'Não foi possível salvar as escolhas agora. Você pode ajustá-las em Configurações.';
    }
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

  List<Widget> _paginas(double tamanhoIlustracao, BuildContext context) {
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
          texto: 'Registre seu humor e responda o questionário toda semana.',
        ),
      ),
      for (var i = 0; i < _perguntas.length; i++)
        _pagina_(_conteudoPergunta(i, context), centralizar: false),
    ];
  }

  Widget _conteudoPergunta(int indice, BuildContext context) {
    final pergunta = _perguntas[indice];
    final selecionada = _respostas[indice];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          'Pergunta ${indice + 1} de ${_perguntas.length}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          pergunta.titulo,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.titulo(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < pergunta.opcoes.length; i++) ...[
          OpcaoResposta(
            texto: pergunta.opcoes[i],
            selecionada: selecionada == i,
            onTap: () {
              if (!_concluindo) _selecionar(indice, i);
            },
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = switch (_temaEscuro) {
      true => AppTheme.dark,
      false => AppTheme.light,
      null => Theme.of(context),
    };
    return Theme(
      data: tema,
      child: Builder(builder: _construirTela),
    );
  }

  Widget _construirTela(BuildContext context) {
    final tamanhoIlustracao = (MediaQuery.sizeOf(context).shortestSide * 0.35)
        .clamp(96.0, 140.0)
        .toDouble();

    return Scaffold(
      appBar: RespiraAppBar(
        titulo: null,
        mostrarVoltar: false,
        leading: _pagina > 0
            ? IconButton(
                tooltip: 'Voltar',
                icon: const Icon(Icons.arrow_back),
                onPressed: _concluindo ? null : _voltar,
              )
            : null,
        acoesExtras: [
          TextButton(
            onPressed: _concluindo
                ? null
                : () => _concluir(configurarLembretes: false),
            child: const Text('Pular'),
          ),
        ],
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
                        color: Theme.of(context).colorScheme.primary,
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
                      physics: _concluindo
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      children: _paginas(tamanhoIlustracao, context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    label: _concluindo
                        ? 'Salvando…'
                        : (_ehUltima ? 'Começar' : 'Continuar'),
                    onPressed: _podeAvancar && !_concluindo ? _avancar : null,
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
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        icone,
        size: tamanho * 0.47,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
