import 'package:flutter/material.dart';
import 'package:template_flutter/common/constants/general.dart';


class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    printLog('screenName $screenName');
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // TODO: implement didReplace
    super.didReplace (newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }
  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }
}
