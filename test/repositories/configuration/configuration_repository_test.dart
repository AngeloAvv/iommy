import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:iommy/errors/repository_error.dart';
import 'package:iommy/repositories/configuration_repository.dart';
import 'package:iommy/services/configuration_service.dart';
import 'package:talker/talker.dart';

import 'configuration_repository_test.mocks.dart';

@GenerateMocks([
  ConfigurationService,
], customMocks: [
  MockSpec<Talker>(unsupportedMembers: {#configure}),
])
void main() {
  late MockTalker logger;
  late MockConfigurationService service;

  late ConfigurationRepository repository;

  setUp(() {
    service = MockConfigurationService();
    logger = MockTalker();

    repository = ConfigurationRepositoryImpl(
      configurationService: service,
      logger: logger,
    );
  });

  group('theme', () {
    late ThemeMode mode;

    setUp(() {
      mode = faker.randomGenerator.element(ThemeMode.values);
    });

    test('theme returned successfully', () async {
      when(service.theme).thenAnswer((_) async => mode);

      final result = await repository.theme;
      expect(result, mode);

      verify(service.theme);
    });

    test('theme throws error', () async {
      when(service.theme).thenThrow(Exception());

      try {
        await repository.theme;
        fail('Should have thrown an error');
      } catch (e) {
        expect(e, isA<RepositoryError>());
      }

      verify(service.theme);
    });
  });

  group('setTheme', () {
    late ThemeMode mode;

    setUp(() {
      mode = faker.randomGenerator.element(ThemeMode.values);
    });

    test('setTheme performed successfully', () async {
      when(service.setTheme(mode)).thenAnswer((_) async {});

      await repository.setTheme(mode);

      verify(service.setTheme(mode));
    });

    test('setTheme throws error', () async {
      when(service.setTheme(mode)).thenThrow(Exception());

      try {
        await repository.setTheme(mode);
        fail('Should have thrown an error');
      } catch (e) {
        expect(e, isA<RepositoryError>());
      }

      verify(service.setTheme(mode));
    });
  });
}
