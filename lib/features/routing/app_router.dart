import 'package:auto_route/auto_route.dart';
import 'package:iommy/pages/main/main_page.dart';
import 'package:iommy/pages/settings/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: MainRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];
}
