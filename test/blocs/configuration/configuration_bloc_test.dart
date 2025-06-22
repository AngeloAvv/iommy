import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/errors/repository_error.dart';
import 'package:iommy/repositories/configuration_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iommy/blocs/configuration/configuration_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'configuration_bloc_test.mocks.dart';

@GenerateMocks([
  ConfigurationRepository,
])
void main() {
  late MockConfigurationRepository configurationRepository;

  late ConfigurationBloc bloc;

  late ThemeMode theme;

  setUp(() {
    configurationRepository = MockConfigurationRepository();

    bloc = ConfigurationBloc(
      configurationRepository: configurationRepository,
    );

    theme = faker.randomGenerator.element(ThemeMode.values);
  });

  /// Testing the event [FetchConfigurationEvent]
  group('when the event FetchConfigurationEvent is added to the BLoC', () {
    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.fetched when fetch is called',
      setUp: () {
        when(configurationRepository.theme).thenAnswer((_) async => theme);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.fetching(),
        ConfigurationState.fetched(
          theme: theme,
        ),
      ],
      verify: (_) {
        verify(configurationRepository.theme);
      },
    );

    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.errorFetching when fetch is called',
      setUp: () {
        when(configurationRepository.theme).thenThrow(RepositoryError(Error()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.fetching(),
        ConfigurationState.errorFetching(RepositoryError(Error())),
      ],
    );

    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.errorFetching when fetch is called',
      setUp: () {
        when(configurationRepository.theme).thenThrow(Error());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.fetch();
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.fetching(),
        ConfigurationState.errorFetching(GenericError()),
      ],
    );
  });
  
  /// Testing the event [SetThemeConfigurationEvent]
  group('when the event SetThemeConfigurationEvent is added to the BLoC', () {
    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.setTheme when setTheme is called',
      setUp: () {
        when(configurationRepository.setTheme(theme)).thenAnswer((_) async => true);
      },
      build: () => bloc,
      act: (bloc) {
        bloc.setTheme(theme);
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.settingTheme(),
        ConfigurationState.setTheme(theme),
        ConfigurationState.fetched(
          theme: theme,
        ),
      ],
      verify: (_) {
        verify(configurationRepository.setTheme(theme));
      },
      seed: () => ConfigurationState.fetched(
        theme: theme,
      ),
    );

    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.errorSettingTheme when setTheme is called',
      setUp: () {
        when(configurationRepository.setTheme(theme)).thenThrow(RepositoryError(Error()));
      },
      build: () => bloc,
      act: (bloc) {
        bloc.setTheme(theme);
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.settingTheme(),
        ConfigurationState.errorSettingTheme(RepositoryError(Error())),
        ConfigurationState.fetched(
          theme: theme,
        ),
      ],
      verify: (_) {
        verify(configurationRepository.setTheme(theme));
      },
      seed: () => ConfigurationState.fetched(
        theme: theme,
      ),
    );

    blocTest<ConfigurationBloc, ConfigurationState>(
      'test that ConfigurationBloc emits ConfigurationState.errorSettingTheme(GenericError()) when setTheme is called',
      setUp: () {
        when(configurationRepository.setTheme(theme)).thenThrow(Error());
      },
      build: () => bloc,
      act: (bloc) {
        bloc.setTheme(theme);
      },
      expect: () => <ConfigurationState>[
        const ConfigurationState.settingTheme(),
        ConfigurationState.errorSettingTheme(GenericError()),
        ConfigurationState.fetched(
          theme: theme,
        ),
      ],
      verify: (_) {
        verify(configurationRepository.setTheme(theme));
      },
      seed: () => ConfigurationState.fetched(
        theme: theme,
      ),
    );
  });
  
}