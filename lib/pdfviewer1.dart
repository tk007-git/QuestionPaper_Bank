// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:question/Str.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer1 extends StatefulWidget {
  String url;
  String name;
  String filename;
  Pdfviewer1({this.url, this.name, this.filename});
  @override
  _Pdfviewer1State createState() => _Pdfviewer1State();
}

class _Pdfviewer1State extends State<Pdfviewer1> {
  Str s = new Str();

  String _fileUrl = "";
  String _fileName = "";
  Dio _dio = Dio();

  String _progress = "-";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fileUrl = widget.url;
    _fileName = widget.name + ".pdf";
    final android = AndroidInitializationSettings('@drawable/ic_action_name');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];
    s.jsond = json;
    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Your question paper is downloaded!' : 'Failure',
        isSuccess
            ? 'Tap to open file.'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  Future<String> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return await appDocPath;
  }

  Future<bool> _requestPermissions() async {
    var permission;

    if (await Permission.storage.request().isGranted) {
      permission = Permission.storage.isGranted;
    } else {
      permission = Permission.storage.isDenied;
    }

    return permission;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(_fileUrl, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
      debugPrint(ex.toString());
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir, widget.filename);
      await _startDownload(savePath);
      print("path " + savePath);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Downloading...'),
          content: Text('$_progress'),
          actions: <Widget>[
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(_).pop();
                },
                child: Text("Cancel"),
              ),
            ),
          ],
        ),
      );
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 5,
        title: Text(
          widget.name + ".pdf",
          style: TextStyle(
              fontFamily: "sans-serif-condensed", fontWeight: FontWeight.bold),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          child: SfPdfViewer.network(
        widget.url,
        pageSpacing: 2,
        enableDoubleTapZooming: true,
        searchTextHighlightColor: Colors.green,
        enableTextSelection: true,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          AlertDialog(
            title: Text(details.error),
            content: Text(details.description),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Download'),
        icon: Icon(Icons.save_outlined),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        tooltip: 'Download',
        onPressed: () => {_download()},
      ),
    );
  }
}
