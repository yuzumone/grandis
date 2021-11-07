// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:grandis/data/model/park_type.dart' as _i5;
import 'package:grandis/ui/detail/detail_page.dart' as _i2;
import 'package:grandis/ui/home/home_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.DetailPage(type: args.type, key: args.key));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomeRoute.name, path: '/'),
        _i3.RouteConfig(DetailRoute.name, path: '/detail-page')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.DetailPage]
class DetailRoute extends _i3.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({required _i5.ParkType type, _i4.Key? key})
      : super(name,
            path: '/detail-page', args: DetailRouteArgs(type: type, key: key));

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({required this.type, this.key});

  final _i5.ParkType type;

  final _i4.Key? key;
}
