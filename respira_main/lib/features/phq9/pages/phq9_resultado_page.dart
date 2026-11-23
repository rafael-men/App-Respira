import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/respira_app_bar.dart';
import '../../cvv/pages/confirmacao_cvv_page.dart';
import '../domain/faixa_phq9.dart';
import '../domain/perguntas_phq9.dart';
import '../domain/resposta_phq9.dart';

/// Tela 06: resultado do PHQ-9 e evolução do escore (F03, RF07, RF08, RN22,
/// RN23).
///
/// Com [resposta], mostra o escore da semana, a faixa e, se a pergunta 9 for
/// maior que zero, o cartão de apoio com acesso à Tela 07. Sem [resposta]
/// (aberta por "Ver minha evolução"), mostra só o gráfico.
class Phq9ResultadoPage extends StatefulWidget {
  const Phq9ResultadoPage({super.key, this.resposta});

  final RespostaPHQ9? resposta;

  @override
  State<Phq9ResultadoPage> createState() => _Phq9ResultadoPageState();
}

class _Phq9ResultadoPageState extends State<Phq9ResultadoPage> {
  Stream<List<RespostaPHQ9>>? _respostas;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _respostas ??= DependenciasScope.of(context).phq9.observarRespostas();
  }

  @override
  Widget build(BuildContext context) {
    final resposta = widget.resposta;
    final precisaApoio = resposta != null &&
        (resposta.respostas[PerguntasPhq9.indicePerguntaSeFerir] ?? 0) > 0;

    return Scaffold(
      appBar: const RespiraAppBar(titulo: 'Seu resultado', mostrarVoltar: false),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  if (resposta != null) ...[
                    _CartaoEscore(escore: resposta.calcularEscore()),
                    const SizedBox(height: 16),
                    Text(
                      'Isso não é um diagnóstico: procure um profissional para '
                      'uma avaliação completa.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (precisaApoio) ...[
                    const _CartaoApoio(),
                    const SizedBox(height: 16),
                  ],
                  StreamBuilder<List<RespostaPHQ9>>(
                    stream: _respostas,
                    builder: (context, snapshot) {
                      var escores = (snapshot.data ?? const <RespostaPHQ9>[])
                          .map((r) => r.calcularEscore())
                          .toList();
                      // A resposta recém-gravada aparece mesmo antes de o
                      // repositório devolver a lista.
                      if (escores.isEmpty && resposta != null) {
                        escores = [resposta.calcularEscore()];
                      }
                      return _CartaoEvolucao(
                        escores: escores,
                        carregando: !snapshot.hasData && resposta == null,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: AppColors.titulo(context),
                    side: BorderSide(
                      color: AppColors.purple500.withValues(alpha: 0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.of(context)
                      .popUntil((rota) => rota.isFirst),
                  child: const Text(
                    'Voltar ao início',
                    style: TextStyle(
                      fontFamily: AppTheme.fonteTitulos,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cartao extends StatelessWidget {
  const _Cartao({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.purple500.withValues(alpha: 0.2)),
      ),
      child: child,
    );
  }
}

class _CartaoEscore extends StatelessWidget {
  const _CartaoEscore({required this.escore});

  final int escore;

  @override
  Widget build(BuildContext context) {
    final faixa = FaixaPhq9.doEscore(escore);

    return _Cartao(
      child: Semantics(
        label: 'Escore desta semana: $escore, faixa ${faixa.rotulo}',
        excludeSemantics: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escore desta semana',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '$escore',
                  key: const Key('phq9-escore'),
                  style: TextStyle(
                    color: AppColors.titulo(context),
                    fontFamily: AppTheme.fonteTitulos,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      faixa.rotulo,
                      key: const Key('phq9-faixa'),
                      style: TextStyle(
                        color: AppColors.titulo(context),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Cartão de apoio quando a pergunta 9 é maior que zero (RN23).
class _CartaoApoio extends StatelessWidget {
  const _CartaoApoio();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.emergency.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.emergency.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Se você estiver pensando em se ferir, você não precisa passar por '
            'isso sozinho(a). O CVV atende 24h, de graça.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.emergency,
                foregroundColor: Colors.white,
              ),
              onPressed: () => ConfirmacaoCvvPage.abrir(context),
              icon: const Icon(Icons.phone),
              label: const Text('Falar com o CVV'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartaoEvolucao extends StatelessWidget {
  const _CartaoEvolucao({required this.escores, required this.carregando});

  final List<int> escores;
  final bool carregando;

  @override
  Widget build(BuildContext context) {
    return _Cartao(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evolução do escore',
            style: TextStyle(
              color: AppColors.titulo(context),
              fontFamily: AppTheme.fonteTitulos,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (carregando)
            const SizedBox(
              height: 160,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (escores.isEmpty)
            Text(
              'Responda o PHQ-9 para ver sua evolução.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            )
          else ...[
            Semantics(
              label: 'Gráfico da evolução do escore: ${escores.join(', ')}',
              excludeSemantics: true,
              child: SizedBox(height: 180, child: _GraficoEscore(escores)),
            ),
            if (escores.length == 1) ...[
              const SizedBox(height: 12),
              Text(
                'Sua evolução aparece a partir da segunda semana.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Gráfico de linha do escore por semana: eixo X "S1, S2...", eixo Y de 0 a
/// 27, traço em gradiente roxo-azul e pontos discretos.
class _GraficoEscore extends StatelessWidget {
  const _GraficoEscore(this.escores);

  final List<int> escores;

  @override
  Widget build(BuildContext context) {
    final estiloEixo = TextStyle(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      fontSize: 11,
    );
    final ultimo = (escores.length - 1).toDouble();

    return LineChart(
      LineChartData(
        minX: escores.length == 1 ? -0.5 : 0,
        maxX: escores.length == 1 ? 0.5 : ultimo,
        minY: 0,
        maxY: 27,
        lineTouchData: const LineTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: 9,
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.purple500.withValues(alpha: 0.12),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 9,
              reservedSize: 28,
              getTitlesWidget: (valor, _) =>
                  Text(valor.toInt().toString(), style: estiloEixo),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 24,
              getTitlesWidget: (valor, _) {
                final semana = valor.round();
                if (valor != semana || semana < 0 || semana >= escores.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('S${semana + 1}', style: estiloEixo),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < escores.length; i++)
                FlSpot(i.toDouble(), escores[i].toDouble()),
            ],
            barWidth: 3,
            isStrokeCapRound: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                AppColors.blue400,
              ],
            ),
            dotData: FlDotData(
              getDotPainter: (spot, percent, barra, indice) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: Theme.of(context).colorScheme.surface,
                    strokeWidth: 2,
                    strokeColor: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
