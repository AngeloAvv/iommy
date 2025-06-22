import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/extensions/commons.dart';
import 'package:iommy/blocs/configuration/configuration_bloc.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/theme_localizations.dart';
import 'package:iommy/pages/settings/widgets/theme_selector_value_sheet.dart';
import 'package:iommy/widgets/loading_widget.dart';
import 'package:settings_ui/settings_ui.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = SettingsThemeData(
      titleTextColor: Theme.of(context).colorScheme.secondary,
      settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
      settingsSectionBackground: Theme.of(context).scaffoldBackgroundColor,
      leadingIconsColor: Theme.of(context).primaryColor,
    );

    final darkTheme = SettingsThemeData(
      titleTextColor: Theme.of(context).colorScheme.secondary,
      settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
      settingsSectionBackground: Theme.of(context).scaffoldBackgroundColor,
      leadingIconsColor: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n?.titleSettings ?? 'titleSettings',
        ),
      ),
      body: BlocBuilder<ConfigurationBloc, ConfigurationState>(
        buildWhen: (_, state) => switch (state) {
          FetchingConfigurationState() => true,
          FetchedConfigurationState() => true,
          ErrorFetchingConfigurationState() => true,
          _ => false,
        },
        builder: (context, state) => switch (state) {
          FetchingConfigurationState() => const LoadingWidget(),
          FetchedConfigurationState(:final theme) => SettingsList(
              lightTheme: lightTheme,
              darkTheme: darkTheme,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              sections: [
                _appSettings(context, theme),
              ],
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }

  AbstractSettingsSection _appSettings(
    BuildContext context,
    ThemeMode theme,
  ) =>
      SettingsSection(
        title: Text(context.l10n?.settingsApp ?? 'settingsApp'),
        tiles: [
          _themeSection(context, theme),
        ],
      );

  AbstractSettingsTile _themeSection(BuildContext context, ThemeMode theme) =>
      SettingsTile(
        title: Text(context.l10n?.settingsTheme ?? 'settingsTheme'),
        leading: const Icon(Icons.lightbulb),
        value: theme.localizedString(context)?.let((it) => Text(it)),
        onPressed: (context) => showModalBottomSheet(
          context: context,
          builder: (context) => ThemeSelectorValueSheet(
            theme,
            onChanged: (theme) => theme?.let(
              (theme) => _setTheme(context, theme),
            ),
          ),
        ),
      );

  void _setTheme(BuildContext context, ThemeMode theme) {
    context.configurationBloc.setTheme(theme);
  }
}
