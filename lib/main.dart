import 'package:flutter/material.dart';
import 'package:flutterapp/CartProvide.dart';
import 'package:provider/provider.dart';

import 'Cart.dart';
import 'Routes.dart';

void main() => runApp(new MaterialApp(home: new DemoApp()));

class DemoApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvide()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: "Flutter_jd",
        initialRoute: "/",
        //Test111111
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primaryColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        locale: const Locale('zn'),
      ),
    );
  }
}
