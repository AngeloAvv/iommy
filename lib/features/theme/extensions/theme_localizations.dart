import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:material_ui/material_ui.dart' hide Route;

extension ThemeLocalizations on ThemeMode {
  String? localizedString(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return context.l10n?.themeLight;
      case ThemeMode.dark:
        return context.l10n?.themeDark;
      case ThemeMode.system:
        return context.l10n?.themeSystem;
    }
  }
}