part of 'configuration_bloc.dart';

@freezed
sealed class ConfigurationState with _$ConfigurationState {
  const factory ConfigurationState.fetching() = FetchingConfigurationState;

  const factory ConfigurationState.fetched({
    required ThemeMode theme,
  }) = FetchedConfigurationState;

  const factory ConfigurationState.errorFetching(LocalizedError error) =
      ErrorFetchingConfigurationState;

  const factory ConfigurationState.settingTheme() =
      SettingThemeConfigurationState;

  const factory ConfigurationState.setTheme(ThemeMode theme) =
      SetThemeConfigurationState;

  const factory ConfigurationState.errorSettingTheme(LocalizedError error) =
      ErrorSettingThemeConfigurationState;
}
