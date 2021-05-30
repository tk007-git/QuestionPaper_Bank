import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question/aboutus.dart';
import 'package:question/credits.dart';
import 'package:question/home.dart';
import 'package:toast/toast.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  void show() {
    Toast.show("Already at home!", context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF70e1f5), Color(0xFFffd194)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 5,
          title: Container(
            // padding: const EdgeInsets.only(left: 60),
            child: Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          leading: new IconButton(
            icon: new Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () => show(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: 180,
                height: 180,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: new RadialGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                  ),
                ),
                child: FlatButton(
                  child: new Text(
                    'Courses',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 180,
                height: 180,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: new RadialGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                  ),
                ),
                child: FlatButton(
                  child: new Text(
                    'Credits',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Credits(),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 180,
                height: 180,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: new RadialGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                  ),
                ),
                child: FlatButton(
                  child: new Text(
                    'About us',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Aboutus(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
