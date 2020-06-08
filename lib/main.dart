import 'package:flutter/material.dart';

import 'Routes.dart';

void main() => runApp(new MaterialApp(home: new DemoApp()));

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter_jd",
      initialRoute: "/",
      //Test111111
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      locale: const Locale('zn'),
    );
  }
}
