import 'package:iommy/blocs/configuration/configuration_bloc.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ThemeSelectorWidgetBuilder = Widget Function(
    BuildContext context, ThemeMode mode);

class ThemeSelector extends StatelessWidget {
  final ThemeSelectorWidgetBuilder builder;

  const ThemeSelector({required this.builder, super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ConfigurationBloc, ConfigurationState>(
        buildWhen: (_, state) => switch (state) {
          FetchedConfigurationState() => true,
          _ => false,
        },
        builder: (context, state) => switch (state) {
          FetchedConfigurationState(:final theme) => builder(context, theme),
          _ => const SizedBox.shrink(),
        },
      );
}
