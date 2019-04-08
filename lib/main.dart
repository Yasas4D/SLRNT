import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:march_proj/root.dart';
import 'package:march_proj/second.dart';
import 'package:march_proj/third.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter LoginPage',
        routes: <String, WidgetBuilder>{
          '/Home': (BuildContext context) => new Home(),
          '/Second': (BuildContext context) => new Second(),
          '/Third': (BuildContext context) => new Third(),
        },
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: new LoginPage());
        home: new Home());
  }
}
