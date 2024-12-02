import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:solar_monitor/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
Future<void> configureDependencies({required String environment}) async =>
    getIt.init(environment: environment);
