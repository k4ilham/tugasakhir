import 'package:flutter/material.dart';
import 'package:tugasakhir/page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'List Card';

    return MaterialApp(
      title: appTitle,
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Home(title: appTitle),
    );
  }
}
