import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iommy/features/localization/app_localizations.dart';

class TestApp extends StatelessWidget {
  final void Function(BuildContext context)? onLoadContext;
  final Widget? home;
  final bool localizationsEnabled;
  final bool excludeSemantics;
  final RootStackRouter? router;
  final ThemeData? theme;

  const TestApp({
    super.key,
    this.onLoadContext,
    this.home,
    this.localizationsEnabled = false,
    this.excludeSemantics = false,
    this.theme,
    this.router,
  });

  @override
  Widget build(BuildContext context) => excludeSemantics
      ? ExcludeSemantics(
          child: _app,
        )
      : _app;

  Widget get _app => router != null
      ? MaterialApp.router(
          routeInformationParser: router!.defaultRouteParser(),
          routerDelegate: router!.delegate(),
          localizationsDelegates: _localizationsDelegate,
          builder: _builder,
          theme: theme,
        )
      : MaterialApp(
          home: home,
          builder: _builder,
          theme: theme,
          localizationsDelegates: _localizationsDelegate,
        );

  Iterable<LocalizationsDelegate<dynamic>>? get _localizationsDelegate =>
      localizationsEnabled
          ? [
              ...AppLocalizations.localizationsDelegates,
            ]
          : null;

  TransitionBuilder get _builder => (context, child) {
        onLoadContext?.call(context);

        return child ?? Container();
      };
}
