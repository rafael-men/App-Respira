import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/aviso_em_breve.dart';
import '../../../core/widgets/danger_button.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../../main/data/preferencias_usuario.dart';
import '../../main/pages/onboarding_page.dart';
import '../../main/widgets/sos_cvv_button.dart';

/// Tela 09: confirmação do Botão de Pânico (F08, RF13, RN07).
///
/// Confirmação em página inteira, sem seta de voltar: a saída é pelo botão
/// "Cancelar" no rodapé (docs/justificativas.md, seção 4).
class PanicoPage extends StatefulWidget {
  const PanicoPage({super.key, this.onSos});

  /// Ação do botão SOS (Tela 07, implementada separadamente).
  final VoidCallback? onSos;

  /// Abre a Tela 09 a partir de qualquer tela (por exemplo, Configurações).
  static Future<void> abrir(BuildContext context, {VoidCallback? onSos}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => PanicoPage(onSos: onSos),
      ),
    );
  }

  @override
  State<PanicoPage> createState() => _PanicoPageState();
}

class _PanicoPageState extends State<PanicoPage> {
  final _senhaController = TextEditingController();

  bool _carregando = false;
  String? _erro;

  @override
  void dispose() {
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _apagarTudo(Dependencias deps) async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final concluida = await deps.exclusao.apagarTudo(
        senha: _senhaController.text,
      );
      if (!mounted) return;

      if (!concluida) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Seus dados foram apagados deste aparelho. A exclusão na nuvem '
              'termina quando houver conexão.',
            ),
          ),
        );
      }

      // Recomeça como no primeiro acesso, com uma nova conta anônima.
      unawaited(deps.auth.entrarSemCadastro().catchError((Object _) {}));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => OnboardingPage(
            authRepository: deps.auth,
            preferencias: PreferenciasUsuario(),
          ),
        ),
        (_) => false,
      );
    } on AuthException catch (e) {
      if (mounted) setState(() => _erro = e.message);
    } catch (_) {
      if (mounted) {
        setState(() => _erro = 'Não foi possível apagar agora. Tente de novo.');
      }
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deps = DependenciasScope.of(context);
    final cadastrado = !deps.auth.anonimo;

    return PopScope(
      canPop: !_carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Botão de Pânico'),
          automaticallyImplyLeading: false,
          actions: [
            SosCvvButton(onPressed: widget.onSos ?? () => avisarEmBreve(context)),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.delete_forever_outlined,
                        size: 56,
                        color: AppColors.emergency,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Apagar todos os seus dados?',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.purple900,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Serão apagados deste aparelho e da nuvem:',
                        style: _estiloTexto,
                      ),
                      const SizedBox(height: 8),
                      const _Item('Todos os registros do diário de humor'),
                      const _Item('Todas as respostas do PHQ-9 e o gráfico'),
                      const _Item('Suas configurações e seu perfil'),
                      _Item(
                        cadastrado
                            ? 'Sua conta (${deps.auth.emailAtual})'
                            : 'Sua conta anônima',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Essa ação não pode ser desfeita.',
                        style: TextStyle(
                          color: AppColors.emergencyDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (cadastrado) ...[
                        const SizedBox(height: 24),
                        TextField(
                          controller: _senhaController,
                          obscureText: true,
                          enabled: !_carregando,
                          autofillHints: const [AutofillHints.password],
                          decoration: const InputDecoration(
                            labelText: 'Digite sua senha para confirmar',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        ),
                      ],
                      if (_erro != null) ...[
                        const SizedBox(height: 16),
                        MensagemErro(mensagem: _erro!),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  children: [
                    DangerButton(
                      label: 'Apagar tudo',
                      carregando: _carregando,
                      onPressed: () => _apagarTudo(deps),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: TextButton(
                        onPressed: _carregando
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _estiloTexto = TextStyle(
  color: AppColors.textPrimary,
  fontSize: 15,
  height: 1.5,
);

class _Item extends StatelessWidget {
  const _Item(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: _estiloTexto),
          Expanded(child: Text(texto, style: _estiloTexto)),
        ],
      ),
    );
  }
}
