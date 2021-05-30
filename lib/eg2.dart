// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:question/pdfviewer1.dart';

class abc extends StatefulWidget {
  String ccourse;
  abc({this.ccourse});
  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {
  String sel, cal, sub;

  List semdata = [];
  var response;
  Future<String> getSemData() async {
    response =
        await http.get(Uri.https('glscall.000webhostapp.com', 'semApi.php'));
    if (response.statusCode == 200) {
      this.setState(() {
        semdata = jsonDecode(response.body) as List;
      });
    } else {
      print("Some error: ${response.statusCode}");
    }

    return "Success!";
  }

  List catdata = [];
  var response1;
  Future<String> getCatData() async {
    response1 = await http
        .get(Uri.https('glscall.000webhostapp.com', 'categoryApi.php'));
    if (response1.statusCode == 200) {
      this.setState(() {
        catdata = jsonDecode(response1.body) as List;
      });
    } else {
      print("Some error: ${response1.statusCode}");
    }

    return "Success!";
  }

  List subdata = [];
  var response3;
  Future<String> getSubData() async {
    response3 =
        await http.get(Uri.https('glscall.000webhostapp.com', 'subApi.php'));
    if (response3.statusCode == 200) {
      this.setState(() {
        subdata = jsonDecode(response3.body) as List;
      });
    } else {
      print("Some error: ${response3.statusCode}");
    }

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSemData();
    this.getCatData();
    this.getSubData();
  }

  @override
  Widget build(BuildContext context) {
    List filtered = [];
    String c = widget.ccourse;
    for (var data in semdata) {
      var courses = data["coursename"];
      if (courses.toString().contains(c)) {
        filtered.add(data);
      }
    }

    List<dynamic> sem() {
      List filter = [];
      if (sel != null && cal == null) {
        filter.clear();
        for (var data in subdata) {
          var sems = data["semester"];
          var courses = data["coursename"];
          if (sems.toString().contains(sel) &&
              courses.toString().contains(widget.ccourse)) {
            filter.add(data);
          }
        }
      } else if (sel == null && cal != null) {
        filter.clear();
        for (var data in subdata) {
          var courses = data["coursename"];
          var catergories = data["category"];
          if (courses.toString().contains(widget.ccourse) &&
              catergories.toString().contains(cal)) {
            filter.add(data);
          }
        }
      } else if (cal != null && sel != null) {
        filter.clear();
        for (var data in subdata) {
          var sem = data["semester"];
          var courses = data["coursename"];
          var catergories = data["category"];
          if (sem.toString().contains(sel) &&
              courses.toString().contains(widget.ccourse) &&
              catergories.toString().contains(cal)) {
            filter.add(data);
          }
        }
      } else {
        filter.clear();
        for (var data in subdata) {
          var courses = data["coursename"];
          if (courses.toString().contains(widget.ccourse)) {
            filter.add(data);
          }
        }
      }
      return filter;
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 5,
        title: Text(
          "Papers",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded:
                              true, //Adding this property, does the magic
                          items: filtered.map((item) {
                            return DropdownMenuItem(
                              child: Center(
                                child: Text(
                                  item['semester'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              value: item['semester'].toString(),
                            );
                          }).toList(),
                          value: sel,
                          hint: Center(
                            child: Text(
                              "Semester",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              sel = val;
                              sem();
                            });
                          }),
                    ),
                  ),
                  VerticalDivider(
                    width: 20,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          // isExpanded: true, //Adding this property, does the magic
                          items: catdata.map((item) {
                            return DropdownMenuItem(
                              child: Center(
                                child: Text(
                                  item['category'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              value: item['category'].toString(),
                            );
                          }).toList(),
                          value: cal,
                          hint: Center(
                            child: Text(
                              "Category",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              cal = val.toString();
                              sem();
                            });
                          }),
                    ),
                  ),
                  // Expanded(
                  //   child: DropdownButton(
                  //       isExpanded: true, //Adding this property, does the magic
                  //       items: filtered.map((item) {
                  //         return   DropdownMenuItem(
                  //           child:   Text(
                  //             item['subject'],
                  //             style: TextStyle(fontSize: 14.0),
                  //           ),
                  //           value: item['subject'].toString(),
                  //         );
                  //       }).toList(),
                  //       hint: Text(
                  //         "Subject",
                  //         style: TextStyle(
                  //           color: Colors.black45,
                  //         ),
                  //       ),
                  //       onChanged: (val) {
                  //         setState(() {
                  //           sub = val.toString();
                  //
                  //           //  print('sel:' + sel!);
                  //         });
                  //       }),
                  // ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 5,
          ),
          Column(
            children: [
              AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sem().length.toInt(),
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pdfviewer1(
                                    url:
                                        "https://glscall.000webhostapp.com/uploads/" +
                                            sem()[index]["file"],
                                    name: sem()[index]["subname"],
                                    filename: sem()[index]["file"],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(12),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  // color: Color.fromRGBO(64, 75, 96, .9),
                                  color: Colors.blueGrey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                    child: Icon(Icons
                                                        .picture_as_pdf_outlined),
                                                    color: Colors.white),
                                                Container(
                                                  child: SizedBox(width: 100),
                                                ),
                                                Container(
                                                  child: Text(
                                                      sem()[index]["subname"] +
                                                          ' - ' +
                                                          sem()[index]["year"],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.chevron_right,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
