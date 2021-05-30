import 'dart:core';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  String firstgls =
      " GLS University has been established with the objective of providing an ideal and creative learning environment and continuing the tradition of excellence in education of the sponsoring body of the University, viz., Gujarat Law Society (GLS) .  ";
  String second =
      "GLS has been awarded several times at national and international levels for its outstanding contribution to education. Following is a brief summary of awards and recognitions:";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 5,
        title: Container(
          // padding: const EdgeInsets.only(left: 60),
          child: Text(
            "About us",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                "Overview",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                firstgls + ".",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                "Awards & Recognition",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                second,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "1. Awards to Gujarat Law Society",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                " • “Gold star Award” by Indian Achievers Form, Bangkok for Excellence in Education by GLS.",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                " • “Best Educationalist Award” by AIMS (Awakening India for Modifying Society) Forum.",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                " • Award for “Best Educational Services – Life time” by All India Academic Applied Psychologists’ Association.",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "2. Awards to GLS University’s President",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                " • The Contemporary Achiever Award by Divyabhaskar as amongst 100 Most Honorable people of Gujarat.",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 40),
              child: Text(
                " • Visionary Award in the field of Law & Education by Vision Foundation of Gujarat.",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 40),
              child: Text(
                " • “ShaleenManavRatna” Award by Anoopam Mission “Indian Achiever Award” by Indo-Thai Business Community Forum Award by All India School Psychologists’ Association for “Services to School Education”.",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
