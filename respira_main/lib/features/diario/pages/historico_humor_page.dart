import 'package:flutter/material.dart';

import '../../../core/widgets/respira_app_bar.dart';
import '../../../core/dependencias.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../domain/registro_humor.dart';
import '../widgets/humor_visual.dart';

class HistoricoHumorPage extends StatefulWidget {
  const HistoricoHumorPage({super.key});
  @override
  State<HistoricoHumorPage> createState() => _HistoricoHumorPageState();
}

class _HistoricoHumorPageState extends State<HistoricoHumorPage> {
  Dependencias? _deps;
  Stream<List<RegistroHumor>>? _registros;
  final _excluindo = <String>{};
  String? _erro;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deps = DependenciasScope.of(context);
    if (!identical(_deps, deps)) {
      _deps = deps;
      _registros = deps.diario.observarRegistros();
    }
  }

  String _data(DateTime data) {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);
    final dia = DateTime(data.year, data.month, data.day);
    String dois(int n) => n.toString().padLeft(2, '0');
    final prefixo = dia == hoje
        ? 'Hoje'
        : dia == DateTime(hoje.year, hoje.month, hoje.day - 1)
        ? 'Ontem'
        : '${dois(data.day)}/${dois(data.month)}';
    return '$prefixo, ${dois(data.hour)}:${dois(data.minute)}';
  }

  Future<void> _excluir(RegistroHumor registro) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmar != true || !mounted) return;
    setState(() {
      _excluindo.add(registro.id);
      _erro = null;
    });
    try {
      await _deps!.diario.excluir(registro.id);
    } on AuthException catch (e) {
      if (mounted) setState(() => _erro = e.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _erro = 'Não foi possível excluir agora. Tente de novo.',
        );
      }
    } finally {
      if (mounted) setState(() => _excluindo.remove(registro.id));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const RespiraAppBar(titulo: 'Histórico do Diário'),
    body: SafeArea(
      child: Column(
        children: [
          if (_erro != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: MensagemErro(mensagem: _erro!),
            ),
          Expanded(
            child: StreamBuilder<List<RegistroHumor>>(
              stream: _registros,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final erro = snapshot.error;
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: MensagemErro(
                      mensagem: erro is AuthException
                          ? erro.message
                          : 'Não foi possível carregar seu diário. Tente de novo.',
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final registros = snapshot.data!;
                if (registros.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Nenhum registro ainda. Que tal registrar como você está agora?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: registros.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, i) {
                    final registro = registros[i];
                    final cor = HumorVisual.cor(registro.humor);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: cor.withValues(alpha: 0.18),
                            child: Text(
                              HumorVisual.emoji(registro.humor),
                              style: const TextStyle(
                                fontFamily: 'Noto Color Emoji',
                                fontFamilyFallback: [
                                  'Apple Color Emoji',
                                  'Segoe UI Emoji',
                                ],
                              ),
                              semanticsLabel:
                                  HumorVisual.rotulos[registro.humor.index],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _data(registro.criadoEm),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(registro.nota ?? '(sem nota)'),
                              ],
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(48, 48),
                            ),
                            onPressed: _excluindo.contains(registro.id)
                                ? null
                                : () => _excluir(registro),
                            child: const Text('× excluir'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'lista em ordem cronológica · toque em excluir para remover',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
