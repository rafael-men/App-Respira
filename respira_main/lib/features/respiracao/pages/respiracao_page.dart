import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/aviso_em_breve.dart';
import '../../main/widgets/sos_cvv_button.dart';

/// Tela 04: respiração guiada no padrão 4-7-8 (F02, RF05, RN13).
///
/// A animação começa sozinha e repete os ciclos até o usuário voltar. É a
/// única animação da tela, e só o círculo é redesenhado a cada quadro, para
/// manter o consumo de bateria baixo em sessões longas (RNF04).
class RespiracaoPage extends StatefulWidget {
  const RespiracaoPage({super.key, this.onSos});

  /// Ação do botão SOS (Tela 07, implementada separadamente).
  final VoidCallback? onSos;

  @override
  State<RespiracaoPage> createState() => _RespiracaoPageState();
}

enum _Etapa {
  inspirar('Inspire', 4),
  segurar('Segure', 7),
  expirar('Expire', 8);

  const _Etapa(this.rotulo, this.segundos);

  final String rotulo;
  final int segundos;
}

class _RespiracaoPageState extends State<RespiracaoPage>
    with SingleTickerProviderStateMixin {
  static const _cicloSegundos = 4 + 7 + 8;
  static const _escalaMinima = 0.6;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: _cicloSegundos),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Converte o progresso do ciclo (0 a 1) na etapa atual, nos segundos que
  /// faltam nela e na escala do círculo.
  static ({_Etapa etapa, int restantes, double escala}) _estado(double t) {
    final segundo = t * _cicloSegundos;
    if (segundo < 4) {
      return (
        etapa: _Etapa.inspirar,
        restantes: (4 - segundo).ceil(),
        escala: _escalaMinima +
            (1 - _escalaMinima) * Curves.easeInOut.transform(segundo / 4),
      );
    }
    if (segundo < 11) {
      return (etapa: _Etapa.segurar, restantes: (11 - segundo).ceil(), escala: 1);
    }
    return (
      etapa: _Etapa.expirar,
      restantes: (_cicloSegundos - segundo).ceil(),
      escala: 1 -
          (1 - _escalaMinima) *
              Curves.easeInOut.transform((segundo - 11) / 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final diametro = (MediaQuery.sizeOf(context).shortestSide * 0.7)
        .clamp(200.0, 320.0)
        .toDouble();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Respiração 4-7-8'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          SosCvvButton(onPressed: widget.onSos ?? () => avisarEmBreve(context)),
        ],
      ),
      body: DecoratedBox(
        // Fundo em tela cheia com a passagem do roxo profundo ao azul claro
        // (docs/justificativas.md, seção 1).
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.purple900, AppColors.purple500, AppColors.blue400],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final estado = _estado(_controller.value);
                    return Semantics(
                      liveRegion: true,
                      label: '${estado.etapa.rotulo}, ${estado.restantes} segundos',
                      excludeSemantics: true,
                      child: SizedBox.square(
                        dimension: diametro,
                        child: Center(
                          child: Transform.scale(
                            scale: estado.escala,
                            child: _Circulo(
                              diametro: diametro,
                              rotulo: estado.etapa.rotulo,
                              restantes: estado.restantes,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Inspire por 4 segundos, segure por 7 e expire por 8.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Voltar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Circulo extends StatelessWidget {
  const _Circulo({
    required this.diametro,
    required this.rotulo,
    required this.restantes,
  });

  final double diametro;
  final String rotulo;
  final int restantes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diametro,
      height: diametro,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Quase opaco, para contraste alto no ponto de maior atenção.
        color: Colors.white.withValues(alpha: 0.95),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rotulo,
            style: const TextStyle(
              color: AppColors.purple900,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$restantes',
            style: const TextStyle(color: AppColors.purple700, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
