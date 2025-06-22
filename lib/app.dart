import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/localizations/flutter_essentials_kit_localizations.dart';
import 'package:iommy/di/dependency_injector.dart';
import 'package:iommy/features/localization/app_localizations.dart';
import 'package:iommy/features/localization/extensions/build_context.dart';
import 'package:iommy/features/routing/app_router.dart';
import 'package:iommy/features/theme/models/theme.dart';
import 'package:iommy/features/theme/widgets/theme_selector.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppRouter? _router;

  @override
  Widget build(BuildContext context) => DependencyInjector(
        child: ThemeSelector(
          builder: (context, mode) {
            _router ??= AppRouter();

            return MaterialApp.router(
              onGenerateTitle: (context) => context.l10n?.appName ?? 'IOMMY',
              debugShowCheckedModeBanner: false,
              routeInformationParser: _router?.defaultRouteParser(),
              routerDelegate: _router?.delegate(),
              theme: LightTheme.make,
              darkTheme: DarkTheme.make,
              themeMode: mode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                FlutterEssentialsKitLocalizations.delegate,
              ],
            );
          },
        ),
      );
}
