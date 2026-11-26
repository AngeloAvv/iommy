import 'package:material_ui/material_ui.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDeviceFilter extends StatelessWidget {
  final String formControlName;
  final String capability;
  final Color? color;

  const ReactiveDeviceFilter(
    this.capability, {
    required this.formControlName,
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color?.withValues(alpha: 0.25),
      border: color?.let((color) => Border.all(color: color)),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.0,
      children: [
        _ReactiveCheckbox(formControlName: formControlName),
        Text(
          capability,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}

/// A [Checkbox] bound to a [FormControl].
///
/// reactive_forms' own `ReactiveCheckbox` is still built on
/// `package:flutter/material.dart`, whose types are incompatible with
/// `material_ui`, so the same binding is rebuilt here on top of
/// [ReactiveFocusableFormField].
class _ReactiveCheckbox extends ReactiveFocusableFormField<bool, bool> {
  _ReactiveCheckbox({required String super.formControlName})
    : super(
        builder: (field) => Checkbox(
          value: field.value ?? false,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          focusNode: field.focusNode,
          onChanged: field.control.enabled ? field.didChange : null,
        ),
      );
}
