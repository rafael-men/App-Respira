import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/dependencias.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../../main/widgets/mood_selector.dart';
import '../domain/registro_humor.dart';
import 'historico_humor_page.dart';

class RegistroHumorPage extends StatefulWidget {
  const RegistroHumorPage({super.key, this.humorInicial});
  final NivelHumor? humorInicial;

  @override
  State<RegistroHumorPage> createState() => _RegistroHumorPageState();
}

class _RegistroHumorPageState extends State<RegistroHumorPage> {
  // Usa a mesma contagem do modelo, inclusive para emojis.
  static final _limiteNota = TextInputFormatter.withFunction(
    (anterior, atual) =>
        atual.text.length <= RegistroHumor.tamanhoMaximoNota ? atual : anterior,
  );

  final _nota = TextEditingController();
  late NivelHumor? _humor = widget.humorInicial;
  bool _salvando = false;
  String? _erro;

  @override
  void dispose() {
    _nota.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_humor == null || _salvando) return;
    final diario = DependenciasScope.of(context).diario;
    setState(() {
      _salvando = true;
      _erro = null;
    });
    try {
      await diario.registrar(RegistroHumor(humor: _humor!, nota: _nota.text));
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registro salvo.')));
      Navigator.of(context).pop();
    } on AuthException catch (e) {
      if (mounted) setState(() => _erro = e.message);
    } catch (_) {
      if (mounted) {
        setState(() => _erro = 'Não foi possível salvar agora. Tente de novo.');
      }
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Diário de Humor'), centerTitle: true),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Como você está se sentindo agora?'),
          const SizedBox(height: 24),
          MoodSelector(
            selecionado: _humor?.index,
            onSelecionado: (i) => setState(() => _humor = NivelHumor.values[i]),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nota,
            enabled: !_salvando,
            minLines: 4,
            maxLines: 8,
            maxLength: RegistroHumor.tamanhoMaximoNota,
            inputFormatters: [_limiteNota],
            decoration: const InputDecoration(
              labelText: 'Nota (opcional)',
              hintText: 'Como foi seu dia? Escreva se quiser...',
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            buildCounter:
                (
                  _, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) {
                  final restantes = maxLength! - _nota.text.length;
                  return restantes < 500
                      ? Text(
                          '$restantes caracteres restantes',
                          style: const TextStyle(fontSize: 12),
                        )
                      : null;
                },
          ),
          if (_erro != null) ...[
            const SizedBox(height: 16),
            MensagemErro(mensagem: _erro!),
          ],
          const SizedBox(height: 24),
          GradientButton(
            label: 'Salvar registro',
            carregando: _salvando,
            onPressed: _humor == null ? null : _salvar,
          ),
          TextButton(
            style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
            onPressed: _salvando
                ? null
                : () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HistoricoHumorPage(),
                    ),
                  ),
            child: const Text('Ver histórico ›'),
          ),
        ],
      ),
    ),
  );
}
