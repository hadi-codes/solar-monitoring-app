import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_monitor/app/view/shell.dart';
import 'package:solar_monitor/monitoring/monitoring.dart';
import 'package:solar_monitor/settings/view/view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home-shell');
final _settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings-shell');
GoRouter buildRouter() => GoRouter(
      initialLocation: '/monitoring',
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => AppShell(
            navigationShell: navigationShell,
          ),
          branches: [
            StatefulShellBranch(
              navigatorKey: _homeNavigatorKey,
              routes: [
                GoRoute(
                  path: '/monitoring',
                  builder: (context, state) {
                    return const MonitoringPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _settingsNavigatorKey,
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const SettingsPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
