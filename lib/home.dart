import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question/egmain.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 5,
        title: Container(
          // padding: const EdgeInsets.only(left: 60),
          child: Text(
            "Courses",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: lst(),
    );
  }
}
