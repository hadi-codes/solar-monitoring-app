// ignore_for_file: depend_on_referenced_packages

import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

/// A module for providing mocks for testing purposes.
@module
abstract class DITestModule {
  @preResolve
  @singleton
  @Environment(Environment.test)
  Future<SharedPreferences> get prefs => Future.value(MockSharedPreferences());
}
