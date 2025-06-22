import 'package:flutter/material.dart';

typedef PreparationFunction = void Function(BuildContext context);

class PreparationWidget extends StatefulWidget {
  final PreparationFunction prepare;
  final Widget child;
  final bool shouldRebuildIfParentChanges;

  const PreparationWidget({
    super.key,
    required this.prepare,
    required this.child,
    this.shouldRebuildIfParentChanges = false,
  });

  @override
  State<StatefulWidget> createState() => _PreparationWidgetState();
}

class _PreparationWidgetState extends State<PreparationWidget> {
  bool _isHotReloaded = false;

  @override
  void initState() {
    widget.prepare(context);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PreparationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.shouldRebuildIfParentChanges && !_isHotReloaded) {
      widget.prepare(context);
    }
    _isHotReloaded = false;
  }

  @override
  void reassemble() {
    _isHotReloaded = true;
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
