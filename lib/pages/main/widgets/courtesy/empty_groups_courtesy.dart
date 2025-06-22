import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class EmptyGroupsCourtesy extends StatelessWidget {
  const EmptyGroupsCourtesy({super.key});

  @override
  Widget build(BuildContext context) => CourtesyWidget(
        title: context.l10n?.labelOops ?? 'labelOops',
        message: context.l10n?.labelEmptyGroups ?? 'labelEmptyGroups',
      );
}
