import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/danger_button.dart';
import '../domain/contato_emergencia.dart';

/// Tela 07: confirmação de chamada ao CVV (F04, RF09, RF10, RN08, RN09).
///
/// Abre com um toque no SOS de qualquer tela (`RespiraAppBar`). A discagem só acontece depois
/// de "Ligar agora"; "Cancelar" volta à tela de origem. O número está no
/// código (`ContatoEmergencia`), então a tela funciona sem internet.
class ConfirmacaoCvvPage extends StatefulWidget {
  const ConfirmacaoCvvPage({
    super.key,
    this.contato = const ContatoEmergencia(),
  });

  final ContatoEmergencia contato;

  /// Abre a Tela 07 em tela cheia, por cima da tela atual.
  static Future<void> abrir(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const ConfirmacaoCvvPage(),
      ),
    );
  }

  @override
  State<ConfirmacaoCvvPage> createState() => _ConfirmacaoCvvPageState();
}

class _ConfirmacaoCvvPageState extends State<ConfirmacaoCvvPage> {
  bool _ligando = false;
  bool _semDiscador = false;

  Future<void> _ligar() async {
    setState(() {
      _ligando = true;
      _semDiscador = false;
    });
    final abriu = await widget.contato.ligar();
    if (!mounted) return;
    setState(() {
      _ligando = false;
      _semDiscador = !abriu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contato = widget.contato;
    final demonstracao = contato.demonstracao;
    final numero = contato.numeroDiscagem;
    final cores = Theme.of(context).colorScheme;
    return Scaffold(
      // Sem seta (sai por "Cancelar") e sem SOS, que abriria esta mesma tela;
      // é assim no protótipo (página 7).
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Central de Valorização da Vida',
          style: TextStyle(
            color: AppColors.titulo(context),
            fontFamily: AppTheme.fonteTitulos,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  children: [
                    const _Circulo188(),
                    const SizedBox(height: 32),
                    Text(
                      demonstracao
                          ? 'SOS · Demonstração'
                          : 'Você está prestes a ligar para o ${ContatoEmergencia.nome}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.titulo(context),
                        fontFamily: AppTheme.fonteTitulos,
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      demonstracao
                          ? numero == null
                                ? 'Configure um número de teste válido para abrir o discador.'
                                : 'Destino do teste: $numero. Confira no discador e cancele antes de ligar.'
                          : 'Atendimento gratuito, sigiloso e 24h, todos os dias da semana.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cores.onSurfaceVariant,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    if (!demonstracao) ...[
                      const SizedBox(height: 24),
                      const _SeloSemInternet(),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  if (_semDiscador) ...[
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        demonstracao
                            ? 'O discador de teste não está disponível neste aparelho.'
                            : 'Ligue ${ContatoEmergencia.numero} pelo telefone do aparelho.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.titulo(context),
                          fontSize: 15,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  DangerButton(
                    label: demonstracao
                        ? 'Abrir discador de teste'
                        : 'Ligar agora',
                    icone: Icons.phone,
                    carregando: _ligando,
                    onPressed: numero == null ? null : _ligar,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: cores.onSurfaceVariant,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Número oficial no círculo vermelho do protótipo.
class _Circulo188 extends StatelessWidget {
  const _Circulo188();

  @override
  Widget build(BuildContext context) {
    final anel = AppColors.emergency.withValues(alpha: 0.18);

    return Semantics(
      label: 'Número oficial do CVV: ${ContatoEmergencia.numero}',
      excludeSemantics: true,
      child: Container(
        width: 176,
        height: 176,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: anel),
        ),
        child: Container(
          width: 152,
          height: 152,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: anel),
          ),
          child: Container(
            width: 128,
            height: 128,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: DangerButton.gradiente,
              boxShadow: [
                BoxShadow(
                  color: AppColors.emergency.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Text(
              ContatoEmergencia.numero,
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppTheme.fonteTitulos,
                fontSize: 44,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SeloSemInternet extends StatelessWidget {
  const _SeloSemInternet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.purple500.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'disponível mesmo sem conexão à internet',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
