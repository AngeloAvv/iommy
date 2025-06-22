import 'package:flutter/material.dart';
import 'package:iommy/features/localization/app_localizations.dart';

extension BuildContextLocalizations on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
