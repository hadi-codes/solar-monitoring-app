import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:monitoring_repository/monitoring_repository.dart';
import 'package:solar_monitor/extension/extension.dart';
import 'package:solar_monitor/l10n/l10n.dart';
import 'package:solar_monitor/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsViewAppbarTitle),
      ),
      body: BlocListener<AppPreferencesCubit, AppPreferencesState>(
        listenWhen: (previous, current) =>
            previous.cacheCleared != current.cacheCleared,
        listener: (_, state) {
          if (state.cacheCleared) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.settingsClearCacheSnackbarSuccess),
              ),
            );
          }
        },
        child: const SingleChildScrollView(
          child: Column(
            children: [
              _LanguageTile(),
              _ThemeTile(),
              _MonitoringTile(),
              _ClearCacheTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final languageName = LocaleNames.of(context)?.nameOf(locale.languageCode) ??
        locale.languageCode;
    return ListTile(
      title: Text(l10n.settingsListTileTitleLanguage),
      subtitle: Text(languageName),
    );
  }
}

class _MonitoringTile extends StatelessWidget {
  const _MonitoringTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appPreferencesCubit = context.read<AppPreferencesCubit>();
    final monitoringUnit = context.select(
      (AppPreferencesCubit cubit) => cubit.state.monitoringUnit,
    );
    return ListTile(
      title: Text(l10n.settingsListTileTitleMeasuringUnit),
      subtitle: Text(monitoringUnit.name.capitalize()),
      onTap: () async {
        final selectedUnit = await showDialog<MonitoringUnit?>(
          context: context,
          builder: (context) => const _MeasuringUnitDialog(),
        );
        if (selectedUnit == null) return;
        await appPreferencesCubit.changeMonitoringUnit(selectedUnit);
      },
    );
  }
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appPreferencesCubit = context.read<AppPreferencesCubit>();
    final themeMode = context.select(
      (AppPreferencesCubit cubit) => cubit.state.themeMode,
    );
    return ListTile(
      title: Text(l10n.settingsListTileTitleTheme),
      subtitle: Text(themeMode.name.capitalize()),
      onTap: () async {
        final pickedThemeMode = await showDialog<ThemeMode?>(
          context: context,
          builder: (context) => const _ThemeDialog(),
        );
        if (pickedThemeMode == null) return;
        await appPreferencesCubit.changeThemeMode(pickedThemeMode);
      },
    );
  }
}

class _ThemeDialog extends StatelessWidget {
  const _ThemeDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeMode = context.select(
      (AppPreferencesCubit cubit) => cubit.state.themeMode,
    );

    return SimpleDialog(
      title: Text(l10n.settingsThemeDialogTitle),
      children: ThemeMode.values
          .map(
            (e) => RadioListTile(
              title: Text(e.name.capitalize()),
              value: e,
              groupValue: themeMode,
              onChanged: (value) {
                Navigator.of(context).pop(value);
              },
            ),
          )
          .toList(),
    );
  }
}

class _MeasuringUnitDialog extends StatelessWidget {
  const _MeasuringUnitDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final monitoringUnit = context.select(
      (AppPreferencesCubit cubit) => cubit.state.monitoringUnit,
    );

    return SimpleDialog(
      title: Text(l10n.settingsMeasuringUnitDialogTitle),
      children: MonitoringUnit.values
          .map(
            (e) => RadioListTile(
              title: Text(e.name.capitalize()),
              value: e,
              groupValue: monitoringUnit,
              onChanged: (value) {
                Navigator.of(context).pop(value);
              },
            ),
          )
          .toList(),
    );
  }
}

class _ClearCacheTile extends StatelessWidget {
  const _ClearCacheTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appPreferencesCubit = context.read<AppPreferencesCubit>();
    return ListTile(
      title: Text(
        l10n.settingsListTileTitleClearCache,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () async {
        final shouldClearCache = (await showDialog<bool?>(
              context: context,
              builder: (context) => const _ClearCacheDialog(),
            )) ??
            false;

        if (shouldClearCache) {
          await appPreferencesCubit.clearCache();
        }
      },
    );
  }
}

class _ClearCacheDialog extends StatelessWidget {
  const _ClearCacheDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.settingsClearCacheDialogTitle),
      content: Text(
        l10n.settingsClearCacheDialogContent,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            l10n.settingsClearCacheDialogButtonCancel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(l10n.settingsClearCacheDialogButtonClear),
        ),
      ],
    );
  }
}
