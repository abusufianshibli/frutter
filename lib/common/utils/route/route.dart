
import 'package:flutter/material.dart';
import 'package:frutter/core/auth/widget/login.dart';
import 'package:frutter/core/custom_order/widget/custom_order_view.dart';
import 'package:frutter/core/feedback/widget/feedback_view.dart';
import 'package:frutter/core/home/widget/home.dart';

class RouteName {
  static String login = "/login";
  static String home = "/home";
  static String customOrder = "/custom_order";
  static String feedback = "/feedback";


}

Map<String, WidgetBuilder> routes({Object? arg}) => {
  RouteName.login: (context) => const LoginScreen(),
  RouteName.home: (context) => const HomePageView(),
  RouteName.customOrder: (context) => const CustomOrderPageView(),
  RouteName.feedback: (context) => const FeedbackPage(),



};

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  final Function? builder =
      routes(arg: routeSettings.arguments)[routeSettings.name];
  if (builder != null) {
    final Route route = MaterialPageRoute(
        settings: routeSettings, builder: (context) => builder(context));
    return route;
  } else {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text('Page not found for ${routeSettings.name}'),
              ),
            ));
  }
}
