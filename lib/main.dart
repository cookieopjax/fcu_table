import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
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
  List<List<String>> timeTableList = [];
  bool hasRequested = false;
  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> data = {
    'Account': account,
    'Password': password,
  };
  void requestData() async {
    var url =
        "https://service206-sds.fcu.edu.tw/mobileservice/CourseService.svc/Timetable2";
    var response = await post(url,
        headers: header, body: json.encode(data), encoding: utf8);
    Map table = jsonDecode(response.body);

    //INITIALIZE
    for (int i = 0; i < 6; i++) {
      timeTableList.add([]);
      for (int j = 0; j < 11; j++) {
        timeTableList[i].add('');
      }
    }

    if (response.statusCode == 200) {
      print('成功！');
      setState(() {
        hasRequested = true;
        for (int indexOfJson = 0;
            indexOfJson < table['TimetableTw'].length;
            indexOfJson++) {
          if (table['TimetableTw'][indexOfJson]['SctWeek'] > 0 &&
              table['TimetableTw'][indexOfJson]['SctWeek'] <= 10) {
            timeTableList[table['TimetableTw'][indexOfJson]['SctWeek']]
                    [table['TimetableTw'][indexOfJson]['SctPeriod']] =
                table['TimetableTw'][indexOfJson]['SubName'];
          }
        }
      });
      return;
    }
    print('Connection Error!');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('逢甲課表'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "禮拜一",
              ),
              Tab(
                text: "禮拜二",
              ),
              Tab(
                text: "禮拜三",
              ),
              Tab(
                text: "禮拜四",
              ),
              Tab(
                text: "禮拜五",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            buildDayTable(1),
            buildDayTable(2),
            buildDayTable(3),
            buildDayTable(4),
            buildDayTable(5),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: requestData,
        ),
      ),
    );
  }

  SingleChildScrollView buildDayTable(int dayIndex) {
    if (hasRequested) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.lightBlue[50],
              height: 100.0,
              child: Text(timeTableList[dayIndex][1] == null
                  ? ' '
                  : timeTableList[dayIndex][1]),
            ),
            Container(
              color: Colors.lightBlue[100],
              height: 100.0,
              child: Text(timeTableList[dayIndex][2] == null
                  ? ' '
                  : timeTableList[dayIndex][2]),
            ),
            Container(
              color: Colors.lightBlue[200],
              height: 100.0,
              child: Text(timeTableList[dayIndex][3] == null
                  ? ' '
                  : timeTableList[dayIndex][3]),
            ),
            Container(
              color: Colors.lightBlue[300],
              height: 100.0,
              child: Text(timeTableList[dayIndex][4] == null
                  ? ' '
                  : timeTableList[dayIndex][4]),
            ),
            Container(
              color: Colors.lightBlue[400],
              height: 100.0,
              child: Text(timeTableList[dayIndex][5] == null
                  ? ' '
                  : timeTableList[dayIndex][5]),
            ),
            Container(
              color: Colors.lightBlue[500],
              height: 100.0,
              child: Text(timeTableList[dayIndex][6] == null
                  ? ' '
                  : timeTableList[dayIndex][6]),
            ),
            Container(
              color: Colors.lightBlue[600],
              height: 100.0,
              child: Text(timeTableList[dayIndex][7] == null
                  ? ' '
                  : timeTableList[dayIndex][7]),
            ),
            Container(
              color: Colors.lightBlue[700],
              height: 100.0,
              child: Text(timeTableList[dayIndex][8] == null
                  ? ' '
                  : timeTableList[dayIndex][8]),
            ),
            Container(
              color: Colors.lightBlue[800],
              height: 100.0,
              child: Text(timeTableList[dayIndex][9] == null
                  ? ' '
                  : timeTableList[dayIndex][9]),
            ),
            Container(
              color: Colors.lightBlue[900],
              height: 100.0,
              child: Text(timeTableList[dayIndex][10] == null
                  ? ' '
                  : timeTableList[dayIndex][10]),
            ),
          ],
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Center(
          child: Text('Press the button'),
        ),
      );
    }
  }
}
