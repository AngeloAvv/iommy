import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';

class GenericError extends LocalizedError {
  @override
  String? localizedString(BuildContext context) => context.l10n?.errorGeneric;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenericError && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
