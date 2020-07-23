import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'loginPage.dart';
import 'main.dart';
//主課表顯示頁面
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> timeTableList = [];//真正要顯示課表的雙重list
  bool hasRequested = false; //判斷是否讀取好課表資料
  String msg = '請按下按鈕'; //除錯用訊息，暫無用到
  Map<String, String> header = {
    'Content-type': 'text/json',
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
    Map table = jsonDecode(response.body); //用Map型態儲存課表json資料

    //INITIALIZE
    for (int i = 0; i < 6; i++) {
      timeTableList.add([]);
      for (int j = 0; j < 11; j++) {
        timeTableList[i].add('');
      }
    }

    print(table['Message']);
    //json中有個'Success'欄位，可知是否有成功登入
    if (table['Success'] == false) {
      setState(() {
        timeTableList[1][1] = table['Message'];
      });
    }

    if (response.statusCode == 200) {
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
              Tab(text: "禮拜一",),
              Tab(text: "禮拜二",),
              Tab(text: "禮拜三",),
              Tab(text: "禮拜四",),
              Tab(text: "禮拜五",),
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
          child: Icon(Icons.autorenew),
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
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][1] == null
                    ? ' '
                    : timeTableList[dayIndex][1],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][2] == null
                    ? ' '
                    : timeTableList[dayIndex][2],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][3] == null
                    ? ' '
                    : timeTableList[dayIndex][3],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][4] == null
                    ? ' '
                    : timeTableList[dayIndex][4],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][5] == null
                    ? ' '
                    : timeTableList[dayIndex][5],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][6] == null
                    ? ' '
                    : timeTableList[dayIndex][6],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][7] == null
                    ? ' '
                    : timeTableList[dayIndex][7],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][8] == null
                    ? ' '
                    : timeTableList[dayIndex][8],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][9] == null
                    ? ' '
                    : timeTableList[dayIndex][9],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[100],
              elevation: 5.0,  //设置阴影
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(timeTableList[dayIndex][10] == null
                    ? ' '
                    : timeTableList[dayIndex][10],
                  style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      requestData();
      return SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: CircularProgressIndicator(//讀取圈圈動畫
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
      );
    }
  }
}