import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsTileBlocBuilder<B extends StateStreamable<S>, S>
    extends AbstractSettingsTile {
  final BlocWidgetBuilder<S> builder;

  const SettingsTileBlocBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<B, S>(builder: builder);
}
