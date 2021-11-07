import 'package:auto_route/auto_route.dart';
import 'package:grandis/ui/detail/detail_page.dart';
import 'package:grandis/ui/home/home_page.dart';

export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: DetailPage),
  ],
)
class $AppRouter {}
