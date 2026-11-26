import 'package:material_ui/material_ui.dart';
import 'package:iommy/features/localization/app_localizations.dart';

extension BuildContextLocalizations on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
