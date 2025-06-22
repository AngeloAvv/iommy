import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class ErrorGroupsCourtesy extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const ErrorGroupsCourtesy({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => CourtesyWidget(
        title: context.l10n?.labelOops ?? 'labelOops',
        message: context.l10n?.labelErrorGroups ?? 'labelErrorGroups',
        onPressed: onPressed,
      );
}
