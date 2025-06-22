import 'dart:async';

import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iommy/errors/generic_error.dart';
import 'package:iommy/repositories/configuration_repository.dart';

part 'configuration_bloc.freezed.dart';
part 'configuration_event.dart';
part 'configuration_state.dart';

/// The ConfigurationBloc
class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository configurationRepository;

  /// Create a new instance of [ConfigurationBloc].
  ConfigurationBloc({
    required this.configurationRepository,
  }) : super(const ConfigurationState.fetching()) {
    on<FetchConfigurationEvent>(_onFetch);
    on<SetThemeConfigurationEvent>(_onSetTheme);
  }

  /// Method used to add the [FetchConfigurationEvent] event
  void fetch() => add(const ConfigurationEvent.fetch());

  /// Method used to add the [SetThemeConfigurationEvent] event
  void setTheme(ThemeMode theme) => add(ConfigurationEvent.setTheme(theme));

  FutureOr<void> _onFetch(
    FetchConfigurationEvent event,
    Emitter<ConfigurationState> emit,
  ) async {
    emit(const ConfigurationState.fetching());

    try {
      final [theme] = await Future.wait([
        configurationRepository.theme,
      ]);

      emit(ConfigurationState.fetched(theme: theme));
    } on LocalizedError catch (error) {
      emit(ConfigurationState.errorFetching(error));
    } catch (_) {
      emit(ConfigurationState.errorFetching(GenericError()));
    }
  }

  FutureOr<void> _onSetTheme(
    SetThemeConfigurationEvent event,
    Emitter<ConfigurationState> emit,
  ) async {
    final currentState = state;

    emit(const ConfigurationState.settingTheme());

    try {
      await configurationRepository.setTheme(event.theme);
      emit(ConfigurationState.setTheme(event.theme));
    } on LocalizedError catch (error) {
      emit(ConfigurationState.errorSettingTheme(error));
    } catch (_) {
      emit(ConfigurationState.errorSettingTheme(GenericError()));
    }

    if (currentState is FetchedConfigurationState) {
      emit((currentState).copyWith(theme: event.theme));
    }
  }
}

extension ConfigurationBlocExtension on BuildContext {
  /// Extension method used to get the [ConfigurationBloc] instance
  ConfigurationBloc get configurationBloc => read<ConfigurationBloc>();
}
