import 'package:flutter/material.dart';

import '../../../core/widgets/respira_app_bar.dart';
import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/domain/usuario.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../../panico/pages/panico_page.dart';
import '../domain/configuracoes.dart';
import 'perfil_page.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  Dependencias? _deps;
  Stream<Usuario?>? _usuario;
  bool _salvando = false;
  String? _erro;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final deps = DependenciasScope.of(context);
    if (!identical(_deps, deps)) {
      _deps = deps;
      _usuario = deps.usuarios.observarUsuario();
    }
  }

  Future<void> _salvar(Configuracoes atual, {required bool alterarTema}) async {
    if (_salvando) return;
    final deps = _deps!;
    setState(() {
      _salvando = true;
      _erro = null;
    });
    final copia = Configuracoes.fromMap(atual.toMap());
    try {
      if (alterarTema) {
        copia.alternarTema();
      } else {
        if (atual.notificacoesAtivas) {
          await deps.lembretes.desativar();
        } else if (!await deps.lembretes.ativar()) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Ative as notificações do Respira nas configurações do celular.',
                ),
              ),
            );
          }
          return;
        }
        copia.alternarNotificacoes();
      }
      await deps.usuarios.salvarConfiguracoes(copia);
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
    appBar: const RespiraAppBar(titulo: 'Configurações'),
    body: SafeArea(
      child: StreamBuilder<Usuario?>(
        stream: _usuario,
        builder: (context, snapshot) {
          final config = snapshot.data?.configuracoes;
          final anonimo = _deps!.auth.anonimo;
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              if (snapshot.connectionState == ConnectionState.waiting)
                const LinearProgressIndicator(),
              if (snapshot.hasError ||
                  (config == null &&
                      snapshot.connectionState != ConnectionState.waiting))
                const MensagemErro(
                  mensagem:
                      'Não foi possível carregar suas preferências. '
                      'Volte e abra Configurações novamente para tentar de novo.',
                ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tema escuro (leitura noturna)'),
                value: config?.temaEscuro ?? false,
                onChanged: _salvando || config == null
                    ? null
                    : (_) => _salvar(config, alterarTema: true),
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Notificações motivacionais'),
                value: config?.notificacoesAtivas ?? false,
                onChanged: _salvando || config == null
                    ? null
                    : (_) => _salvar(config, alterarTema: false),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                minTileHeight: 56,
                title: const Text('Perfil'),
                subtitle: anonimo
                    ? const Text('Crie uma conta para personalizar')
                    : null,
                trailing: anonimo
                    ? const Icon(Icons.lock_outline)
                    : const Icon(Icons.chevron_right),
                onTap: anonimo ? null : () => PerfilPage.abrir(context),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                minTileHeight: 56,
                title: const Text('Sobre o Respira'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: 'Respira',
                  applicationVersion: '1.0.0+1',
                  children: const [
                    Text(
                      'O Respira é um apoio entre atendimentos e não substitui ajuda profissional. Em crise, ligue 188 (CVV).',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Material(
                color: AppColors.emergency.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.emergency),
                ),
                child: ListTile(
                  minTileHeight: 80,
                  leading: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    'Botão de Pânico',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'apagar todos os dados locais e da nuvem',
                  ),
                  onTap: () => PanicoPage.abrir(context),
                ),
              ),
              if (_erro != null) ...[
                const SizedBox(height: 16),
                MensagemErro(mensagem: _erro!),
              ],
            ],
          );
        },
      ),
    ),
  );
}
