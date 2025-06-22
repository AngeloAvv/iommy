import 'package:flutter/material.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class ExpandAllButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const ExpandAllButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        child: Text(
          context.l10n?.actionExpandAll ?? 'actionExpandAll',
        ),
      );
}
