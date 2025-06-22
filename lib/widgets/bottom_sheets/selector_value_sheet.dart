import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';

typedef OnSelectedValueChanged<T> = void Function(T? fuelType);
typedef LocalizeValue<T> = String? Function(T value);

class SelectorValueSheet<T> extends StatelessWidget {
  final String? title;
  final List<T> values;
  final T? initialValue;
  final OnSelectedValueChanged<T>? onSelectedValueChanged;
  final LocalizeValue<T>? localizeTitle;
  final LocalizeValue<T>? localizeSubtitle;

  const SelectorValueSheet({
    super.key,
    required this.title,
    required this.values,
    this.onSelectedValueChanged,
    this.initialValue,
    this.localizeTitle,
    this.localizeSubtitle,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sortingCriteriaWidgets(context),
        ],
      ),
    ),
  );

  Widget _sortingCriteriaWidgets(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null) Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      ...values.map(
            (value) => RadioListTile<T>(
          value: value,
          groupValue: value == initialValue ? value : null,
          onChanged: (value) => context.maybePop().then(
                (_) => onSelectedValueChanged?.call(value),
          ),
          title: Text(localizeTitle?.call(value) ?? value.toString()),
          subtitle: localizeSubtitle?.let((localizeSubtitle) => Text(localizeSubtitle.call(value) ?? value.toString())),
        ),
      ),
    ],
  );
}
