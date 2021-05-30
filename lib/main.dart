import 'package:flutter/material.dart';
import 'package:question/splash.dart';
// void main() => runApp(new MyApp());

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
          fontFamily: 'all',
          primaryColor: Color(0xff365761),
          accentColor: Colors.blueGrey),
    );
  }
}
