import 'package:flutter/material.dart';
import 'package:template_flutter/views/gallery_view/gallery_view_screen.dart';
import 'package:template_flutter/views/home_screen.dart';
import 'package:template_flutter/views/image_slider/image_slider.dart';
import 'package:template_flutter/views/map/map_screen.dart';
import 'package:template_flutter/views/notification/notification_screen.dart';
import 'package:template_flutter/views/progress_state_button/progress_state_button.dart';

import 'common/constants/routes.dart';
import 'views/checkbox/multi_checkbox_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static final Map<String, WidgetBuilder> _routes = {
    HomeScreen.id: (context) => HomeScreen(),
    NotificationScreen.id: (context) => NotificationScreen(),
    MapScreen.id: (context) => MapScreen(),
    ProgressStateButtonScreen.id: (context) => ProgressStateButtonScreen(),
    GalleryViewScreen.id: (context) => GalleryViewScreen(),
    ImageSlider.id: (context) => ImageSlider(),
    MultiCheckboxScreen.id: (context) => MultiCheckboxScreen(),
  };

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.home:
        return _buildRouteFade(settings, HomeScreen());
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
