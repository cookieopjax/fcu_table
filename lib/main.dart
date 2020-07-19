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
  String temp = "請按右下方按鈕新增資料";
  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> data = {
    'Account': account,
    'Password': password,
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
        temp = table['TimetableTw'][5]['SubName'];
      });
      return response.body;
    }
    print('Connection Error!');
    return '<html>error! status:${response.statusCode}</html>';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title:Text('逢甲課表'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text:"禮拜一",
              ),
              Tab(
                text:"禮拜二",
              ),
              Tab(
                text:"禮拜三",
              ),
              Tab(
                text:"禮拜四",
              ),
              Tab(
                text:"禮拜五",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Text(temp),
            Text('2'),
            Text('3'),
            Text('4'),
            Text('5'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: requestData,
        ),
      ),
    );
  }
}