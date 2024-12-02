import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:solar_monitor/l10n/l10n.dart';

/// A mixin that provides network connectivity awareness to
/// StatefulWidget states.
///
/// This mixin monitors network connectivity changes and automatically shows/hides
/// a SnackBar when the device loses/regains network connection. It supports
/// various types of network connections including
/// mobile, WiFi, VPN, and ethernet.
///
/// Usage:
/// ```dart
/// class _MyWidgetState extends State<MyWidget> with NetworkAwareMixin {
///   // Your widget state implementation
/// }
/// ```
///
/// The mixin automatically:
/// * Initializes network monitoring when the widget is created
/// * Shows a persistent SnackBar when the device loses network connection
/// * Hides the SnackBar when the device regains network connection
mixin NetworkAwareMixin<T extends StatefulWidget> on State<T> {
  bool _isDisconnected = false;

  StreamSubscription<List<ConnectivityResult>>? _networkSubscription;
  final _connectivity = Connectivity();

  void onReconnected() {
    ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  }

  void onDisconnected() {
    final message = context.l10n.noInternetConnection;
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: const Duration(days: 1),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        dismissDirection: DismissDirection.none,
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _networkSubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    final allowedResults = [
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.vpn,
      ConnectivityResult.ethernet,
      ConnectivityResult.other,
    ];

    _isDisconnected = !result.any(allowedResults.contains);

    if (_isDisconnected) {
      onDisconnected();
    } else {
      onReconnected();
    }
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }

  void cancelSubscription() {
    try {
      _networkSubscription?.cancel();
    } catch (e) {
      debugPrint('Error cancelling subscription: $e');
    }
  }
}
