import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'loginPage.dart';

void main() => runApp(MyApp());

String account = '';
String password = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String temp = "1234";
  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> data = {
    'Account': 'D0843837',
    'Password': 'Vigor01695',
  };
  requestData() async {
    var url =
        "https://service206-sds.fcu.edu.tw/mobileservice/CourseService.svc/Timetable2";
    var response = await post(url,
        headers: header, body: json.encode(data), encoding: utf8);
    Map table = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.runtimeType);
      setState(() {
        temp = table['TimetableTw'][1]['ClsName'];
      });
      return response.body;
    }
    print('Connection Error!');
    return '<html>error! status:${response.statusCode}</html>';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(temp),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: requestData,
      ),
    );
  }
}
