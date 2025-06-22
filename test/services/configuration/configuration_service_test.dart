import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:iommy/services/configuration_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

import 'configuration_service_test.mocks.dart';

/// Test case for the class ConfigurationServiceImpl
@GenerateMocks([], customMocks: [
  MockSpec<Talker>(unsupportedMembers: {#configure}),
])
void main() {
  late Future<SharedPreferences> sharedPrefs;
  late MockTalker logger;

  late ConfigurationService service;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    sharedPrefs = SharedPreferences.getInstance();

    logger = MockTalker();

    service = ConfigurationServiceImpl(
      sharedPreferences: sharedPrefs,
      logger: logger,
    );
  });

  group('[ConfigurationService] Testing theme', () {
    test('test get theme (default)', () async {
      expect(await service.theme, ThemeMode.system);
    });

    test('test get theme', () async {
      (await sharedPrefs).setString('theme', ThemeMode.system.name);

      expect(await service.theme, ThemeMode.system);
    });
  });

  group('[ConfigurationService] Testing setTheme', () {
    test('test setTheme', () async {
      expect((await sharedPrefs).getString('theme'), isNull);

      await service.setTheme(ThemeMode.system);

      expect((await sharedPrefs).getString('theme'), ThemeMode.system.name);
    });
  });
}
