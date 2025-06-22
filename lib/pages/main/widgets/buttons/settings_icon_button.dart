import 'package:flutter/material.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class SettingsIconButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const SettingsIconButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.settings),
        tooltip: context.l10n?.actionSettings ?? 'actionSettings',
        onPressed: onPressed,
      );
}
