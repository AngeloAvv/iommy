import 'package:flutter/material.dart';
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
        ReactiveCheckbox(
          visualDensity: const VisualDensity(
            horizontal: -4,
            vertical: -4,
          ),
          formControlName: formControlName,
          // activeColor: Theme.of(context).primaryColor,
        ),
        Text(
          capability,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}
