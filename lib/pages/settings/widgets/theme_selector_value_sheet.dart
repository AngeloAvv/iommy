import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/theme/extensions/theme_localizations.dart';
import 'package:iommy/widgets/bottom_sheets/selector_value_sheet.dart';
import 'package:flutter/material.dart' hide Route;

class ThemeSelectorValueSheet extends StatelessWidget {
  final ThemeMode theme;
  final OnSelectedValueChanged<ThemeMode>? onChanged;

  const ThemeSelectorValueSheet(this.theme, {super.key, this.onChanged});

  @override
  Widget build(BuildContext context) => SelectorValueSheet<ThemeMode>(
    title: context.l10n?.settingsTheme,
    values: ThemeMode.values,
    initialValue: theme,
    localizeTitle: (theme) => theme.localizedString(context),
    onSelectedValueChanged: onChanged,
  );
}
