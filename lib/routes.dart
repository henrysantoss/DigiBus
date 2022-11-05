import 'package:flutter/material.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}