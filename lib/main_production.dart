import 'package:injectable/injectable.dart';
import 'package:solar_monitor/app/app.dart';
import 'package:solar_monitor/bootstrap.dart';

void main() {
  bootstrap(() => const App(), environment: Environment.prod);
}
