import 'package:flutter/material.dart';
import 'package:solar_monitor/l10n/l10n.dart';
import 'package:solar_monitor/ui/ui.dart';

/// {@template error_widget}
/// Widget to display an error message with a retry button.
/// {@endtemplate}
class AppErrorWidget extends StatelessWidget {
  /// {@macro error_widget}
  const AppErrorWidget({super.key, this.onRetry, this.message});

  /// An optional callback which is invoked when the retry button is pressed.
  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.xlg),
          Icon(
            Icons.error_outline,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message ?? l10n.errorWidgetText,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxlg),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: onRetry,
                label: Text(
                  l10n.retry,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.xlg),
        ],
      ),
    );
  }
}
