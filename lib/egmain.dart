import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:question/eg2.dart';

class lst extends StatefulWidget {
  @override
  _lstState createState() => _lstState();
}

class _lstState extends State<lst> {
  String imgurl = "https://glscall.000webhostapp.com/imgupload/";
  List data = [];
  var response;
  Future<String> getData() async {
    response =
        await http.get(Uri.https('glscall.000webhostapp.com', 'courseApi.php'));
    if (response.statusCode == 200) {
      // code 200 = 'ok'
      // print(response.statusCode);
      // print(response.body);
      this.setState(() {
        data = jsonDecode(response.body) as List;
      });
    } else {
      print("Some error: ${response.statusCode}");
    }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: data.isNotEmpty
          ? StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: 4,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => Card(
                    child: InkResponse(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child:
                                  Image.network(imgurl + data[index]["image"])),
                          Text(
                            data[index]["coursename"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => abc(
                            ccourse: data[index]["coursename"],
                          ),
                        ),
                      ),
                    ),
                  ),
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(2, index.isEven ? 2.6 : 2.4);
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  FadingText(
                    'Please wait...',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
    );
  }
}
