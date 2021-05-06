import 'package:flutter/material.dart';
import 'package:template_flutter/views/home_screen.dart';

import 'common/constants/routes.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static final Map<String, WidgetBuilder> _routes = {
    "/home": (context) => HomeScreen(),
  };

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.home:
        return _buildRouteFade(
          settings,
         HomeScreen()
        );
      default:
        return _errorRoute();
    }
  }

  static WidgetBuilder? getRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouteList.home];
    }
    return _routes[name];
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      );
    });
  }

  static PageRouteBuilder _buildRouteFade(
      RouteSettings settings, Widget builder) {
    return _FadedTransitionRoute(settings: settings, widget: builder);
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
            settings: settings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity:
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                child: child,
              );
            });
}
