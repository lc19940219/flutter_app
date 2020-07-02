import 'package:flutter/material.dart';
import 'package:flutterapp/LoginPage.dart';
import 'package:flutterapp/ProductContent.dart';
import 'package:flutterapp/pages/Tabs.dart';

import 'ProductListPage.dart';
import 'RegistFirst.dart';
import 'RegistThree.dart';
import 'RegistTwo.dart';

final routes = {
  "/": (context) => Tabs(),
  "/ProductListPage": (context, {arguments}) =>
      ProductListPage(arguments: arguments),
  "/ProductContent": (context, {arguments}) =>
      ProductContent(arguments: arguments),
  '/Login': (context) => LoginPage(),
  '/RegistFirst': (context) => RegistFirst(),
  '/RegistTwo': (context, {arguments}) => RegistTwo(arguments: arguments),
  '/RegistThree': (context, {arguments}) => RegistThree(arguments: arguments),
};

Route<dynamic> Function(RouteSettings settings) onGenerateRoute =
    (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }
  }
  final Route route =
      MaterialPageRoute(builder: (context) => pageContentBuilder(context));
  return route;
};
