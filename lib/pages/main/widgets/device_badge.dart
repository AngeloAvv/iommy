import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';

class DeviceBadge extends StatelessWidget {
  final String capability;
  final Color? color;

  const DeviceBadge(
    this.capability, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color?.withValues(alpha: 0.25),
            border: color?.let((color) => Border.all(color: color)),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            capability,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
}
