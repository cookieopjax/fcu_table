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
  List<String> week = ['請按右下角按鈕', '', '','','','','','','','','','','',''];
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
      print(table['TimetableTw'].length);
      int counter = 1;
      setState(() {
        for(int i=0;i<41;i++){
          if(table['TimetableTw'][i]['SctWeek']==1){
            if(table['TimetableTw'][i]['SctPeriod'] != table['TimetableTw'][i-1]['SctPeriod']) {
              week[counter] = table['TimetableTw'][i]['SubName'];
              counter++;
            }
          }
        }
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
              Tab(text:"禮拜一",),
              Tab(text:"禮拜二",),
              Tab(text:"禮拜三",),
              Tab(text:"禮拜四",),
              Tab(text:"禮拜五",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(week[0]),
                Text(week[1]),
                Text(week[2]),
                Text(week[3]),
                Text(week[4]),
                Text(week[5]),
                Text(week[6]),
                Text(week[7]),
                Text(week[8]),
                Text(week[9]),
                Text(week[10]),
              ],
            ),
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