import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/dependencias.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../auth/domain/usuario.dart';
import '../../auth/pages/cadastro_page.dart';
import '../../auth/widgets/auth_widgets.dart';
import '../data/usuario_repository.dart';

/// Perfil opcional: nome de usuário e foto (RF20, RN20). Só para usuário
/// cadastrado; quem usa sem conta vê um convite para criar a conta.
class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  static Future<void> abrir(BuildContext context) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const PerfilPage()));
  }

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _nomeController = TextEditingController();

  bool _iniciado = false;
  bool _carregando = true;
  bool _salvando = false;
  bool _anonimo = true;
  String? _fotoAtual;
  String? _fotoNova;
  bool _removerFoto = false;
  String? _erro;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_iniciado) return;
    _iniciado = true;
    _carregar();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    final deps = DependenciasScope.of(context);
    final usuario = await deps.usuarios.observarUsuario().first;
    if (!mounted) return;
    setState(() {
      _anonimo = deps.auth.anonimo;
      _nomeController.text = usuario?.nomeUsuario ?? '';
      _fotoAtual = usuario?.fotoPerfil;
      _carregando = false;
    });
  }

  String? get _fotoExibida {
    if (_removerFoto) return null;
    return _fotoNova ?? _fotoAtual;
  }

  Future<void> _escolherFoto() async {
    setState(() => _erro = null);
    try {
      final arquivo = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 70,
      );
      if (arquivo == null) return;
      final bytes = await arquivo.readAsBytes();
      if (!mounted) return;
      setState(() {
        _fotoNova = base64Encode(bytes);
        _removerFoto = false;
      });
    } on Exception {
      if (mounted) {
        setState(
          () => _erro = 'Não foi possível abrir a galeria. Tente de novo.',
        );
      }
    }
  }

  void _removerFotoAtual() {
    setState(() {
      _fotoNova = null;
      _removerFoto = true;
      _erro = null;
    });
  }

  Future<void> _salvar() async {
    setState(() {
      _salvando = true;
      _erro = null;
    });
    final nome = _nomeController.text.trim();
    final navegador = Navigator.of(context);
    final mensagem = ScaffoldMessenger.of(context);
    try {
      await DependenciasScope.of(context).usuarios.atualizarPerfil(
        nomeUsuario: nome.isEmpty ? null : nome,
        fotoPerfil: _fotoExibida,
      );
      mensagem.showSnackBar(const SnackBar(content: Text('Perfil salvo.')));
      navegador.pop();
    } on PerfilException catch (e) {
      if (mounted) setState(() => _erro = e.message);
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  void _criarConta() {
    final auth = DependenciasScope.of(context).auth;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CadastroPage(authRepository: auth)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.purple900,
      ),
      body: SafeArea(
        child: _carregando
            ? const Center(child: CircularProgressIndicator())
            : _anonimo
            ? _conviteCadastro()
            : _formulario(),
      ),
    );
  }

  Widget _conviteCadastro() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Crie uma conta para personalizar seu perfil.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.purple900,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              GradientButton(label: 'Criar conta', onPressed: _criarConta),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    final foto = _fotoExibida;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: AuthCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor: AppColors.purple500.withValues(
                      alpha: 0.15,
                    ),
                    backgroundImage: foto == null
                        ? null
                        : MemoryImage(base64Decode(foto)),
                    child: foto == null
                        ? const Icon(
                            Icons.person_outline,
                            size: 56,
                            color: AppColors.purple700,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: _salvando ? null : _escolherFoto,
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Escolher foto'),
                    ),
                    TextButton(
                      onPressed: _salvando || foto == null
                          ? null
                          : _removerFotoAtual,
                      child: const Text('Remover foto'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nomeController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _salvar(),
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuário (opcional)',
                    helperText: 'Até ${Usuario.tamanhoMaximoNome} caracteres',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Seu nome e sua foto aparecem só para você. Nada é compartilhado.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                if (_erro != null) ...[
                  const SizedBox(height: 16),
                  MensagemErro(mensagem: _erro!),
                ],
                const SizedBox(height: 24),
                GradientButton(
                  label: 'Salvar',
                  carregando: _salvando,
                  onPressed: _salvar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
