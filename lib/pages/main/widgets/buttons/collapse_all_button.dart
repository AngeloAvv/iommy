import 'package:flutter/material.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class CollapseAllButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const CollapseAllButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        child: Text(
          context.l10n?.actionCollapseAll ?? 'actionCollapseAll',
        ),
      );
}
