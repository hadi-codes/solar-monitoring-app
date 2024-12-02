import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:solar_monitor/app/router/router.dart';
import 'package:solar_monitor/app/widget/app_providers.dart';
import 'package:solar_monitor/l10n/l10n.dart';
import 'package:solar_monitor/settings/settings.dart';
import 'package:solar_monitor/ui/ui.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final router = buildRouter();
  @override
  Widget build(BuildContext context) {
    return AppProviders(
      builder: (context) {
        final themeMode = context.select(
          (AppPreferencesCubit cubit) => cubit.state.themeMode,
        );

        return MaterialApp.router(
          themeMode: themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LocaleNamesLocalizationsDelegate(),
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        );
      },
    );
  }
}
