import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Lembretes motivacionais não invasivos (F09, RF14). A Tela 08 liga e
/// desliga os lembretes por este serviço, além de salvar a preferência em
/// `Configuracoes.notificacoesAtivas`.
abstract class LembretesService {
  /// Pede a permissão de notificação e agenda o lembrete diário. Devolve
  /// `false` se a permissão for negada ou a plataforma não tiver suporte
  /// (por exemplo, no navegador).
  Future<bool> ativar();

  /// Cancela todos os lembretes agendados.
  Future<void> desativar();
}

/// Versão em memória, para desenvolver e testar as telas sem notificações
/// reais.
class MemoriaLembretesService implements LembretesService {
  MemoriaLembretesService({this.permitido = true});

  /// Simula a resposta do pedido de permissão.
  final bool permitido;

  bool _ativo = false;

  bool get ativo => _ativo;

  @override
  Future<bool> ativar() async {
    _ativo = permitido;
    return permitido;
  }

  @override
  Future<void> desativar() async => _ativo = false;
}

/// Lembretes reais com notificações locais (sem servidor e sem internet).
/// Um lembrete por dia, sem som e sem vibração, com texto sem cobrança
/// (F09, RNF02).
class LocalLembretesService implements LembretesService {
  LocalLembretesService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _inicializado = false;

  static const _idLembrete = 1;
  static const _titulo = 'Respira';
  static const _texto = 'Que tal registrar como você está hoje? Sem pressa.';

  static const _detalhes = NotificationDetails(
    android: AndroidNotificationDetails(
      'lembretes_respira',
      'Lembretes motivacionais',
      channelDescription: 'Um lembrete por dia para registrar como você está.',
      importance: Importance.low,
      priority: Priority.low,
      playSound: false,
      enableVibration: false,
    ),
    iOS: DarwinNotificationDetails(presentSound: false),
  );

  bool get _suportado =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> _inicializar() async {
    if (_inicializado) return;
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _inicializado = true;
  }

  Future<bool> _pedirPermissao() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await android?.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    return await ios?.requestPermissions(alert: true) ?? false;
  }

  @override
  Future<bool> ativar() async {
    if (!_suportado) return false;
    try {
      await _inicializar();
      if (!await _pedirPermissao()) return false;
      await _plugin.periodicallyShow(
        id: _idLembrete,
        title: _titulo,
        body: _texto,
        repeatInterval: RepeatInterval.daily,
        notificationDetails: _detalhes,
        // Inexato basta para um lembrete diário e dispensa a permissão de
        // alarme exato do Android 14.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      return true;
    } on Object catch (e) {
      debugPrint('Respira: não foi possível agendar o lembrete: $e');
      return false;
    }
  }

  @override
  Future<void> desativar() async {
    if (!_suportado) return;
    try {
      await _inicializar();
      await _plugin.cancelAll();
    } on Object catch (e) {
      debugPrint('Respira: não foi possível cancelar os lembretes: $e');
    }
  }
}
