import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey('AppShell'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (value) => _goBranch(value, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(MingCute.home_1_line),
            selectedIcon: Icon(MingCute.home_1_fill),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(MingCute.settings_1_line),
            selectedIcon: Icon(MingCute.settings_1_fill),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
