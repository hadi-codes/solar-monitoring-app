import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_monitor/di/di.dart';
import 'package:solar_monitor/settings/settings.dart';

/// Function type for building widgets with the provided context
/// from [AppProviders].
typedef AppProvidersBuilder = Widget Function(BuildContext context);

/// A widget that provides application-wide state management
/// through Bloc providers.
///
/// This widget serves as a central provider for various application states,
/// wrapping the widget tree with necessary Bloc providers.
/// It uses [MultiBlocProvider]
/// to efficiently manage multiple Bloc instances.
///
/// Example usage:
/// ```dart
/// AppProviders(
///   builder: (context) => MyApp(),
/// )
/// ```
class AppProviders extends StatelessWidget {
  /// Creates an [AppProviders] widget.
  ///
  /// The [builder] parameter is required and defines how the child widget tree
  /// should be constructed with access to all provided Blocs.
  const AppProviders({required this.builder, super.key});

  /// A builder function that constructs the child widget tree.
  ///
  /// This builder has access to all Bloc providers defined in this widget.
  final AppProvidersBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppPreferencesCubit>(),
        ),
      ],
      child: Builder(
        builder: builder,
      ),
    );
  }
}
