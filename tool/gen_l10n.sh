#!/usr/bin/env bash
# Regenerates lib/features/localization/app_localizations*.dart from the ARB files.
#
# gen-l10n of Flutter 3.50 emits references to the deprecated flutter_localizations
# classes (GlobalMaterialLocalizations & co.) and has no option to avoid it, so the
# generated files are committed instead of being produced at build time, and the
# delegates list is switched to material_ui here. Once the project moves to a Flutter
# release that includes flutter/flutter#194500, drop this script, restore l10n.yaml
# and set `flutter: generate: true` again.
set -euo pipefail
cd "$(dirname "$0")/.."

out=lib/features/localization
backup=$(mktemp)
cp pubspec.yaml "$backup"
trap 'cp "$backup" pubspec.yaml; rm -f "$backup"' EXIT

# gen-l10n refuses to run unless `generate: true` is set.
perl -0pi -e 's/^flutter:\n/flutter:\n  generate: true\n/m' pubspec.yaml

flutter gen-l10n \
  --arb-dir=$out/resources \
  --template-arb-file=app_en.arb \
  --output-dir=$out

perl -0pi -e '
  s{import .package:flutter_localizations/flutter_localizations.dart.;\n}{};
  s{(import .package:intl/intl.dart. as intl;\n)}{$1import \x27package:material_ui/material_ui.dart\x27 show GlobalMaterialLocalizations;\n};
  s{GlobalMaterialLocalizations\.delegate, GlobalCupertinoLocalizations\.delegate,\n  /// and GlobalWidgetsLocalizations\.delegate\.}{GlobalMaterialLocalizations.delegates.};
  s{    GlobalMaterialLocalizations\.delegate,\n    GlobalCupertinoLocalizations\.delegate,\n    GlobalWidgetsLocalizations\.delegate,\n}{    ...GlobalMaterialLocalizations.delegates,\n};
' $out/app_localizations.dart

dart format $out/app_localizations.dart $out/app_localizations_en.dart
