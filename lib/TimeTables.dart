import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

//主課表顯示頁面
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> timeTableListName = [];//真正要顯示課表課名的雙重list
  List<List<String>> timeTableListPlace = [];//真正要顯示上課位置的雙重list
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
      timeTableListName.add([]);
      timeTableListPlace.add([]);
      for (int j = 0; j < 11; j++) {
        timeTableListName[i].add('');
        timeTableListPlace[i].add('');
      }
    }

    print(table['Message']);
    //json中有個'Success'欄位，可知是否有成功登入
    if (table['Success'] == false) {
      setState(() {
        timeTableListName[1][1] = table['Message'];
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
            timeTableListName[table['TimetableTw'][indexOfJson]['SctWeek']]
            [table['TimetableTw'][indexOfJson]['SctPeriod']] =
            table['TimetableTw'][indexOfJson]['SubName'];
          }
        }
        for (int indexOfJson = 0;
        indexOfJson < table['TimetableTw'].length;
        indexOfJson++) {
          if (table['TimetableTw'][indexOfJson]['SctWeek'] > 0 &&
              table['TimetableTw'][indexOfJson]['SctWeek'] <= 10) {
            timeTableListPlace[table['TimetableTw'][indexOfJson]['SctWeek']]
            [table['TimetableTw'][indexOfJson]['SctPeriod']] =
            table['TimetableTw'][indexOfJson]['RomName'];
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
            //unselectedLabelColor: Colors.white,
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
            for(int i=1;i<=10;i++)
              if(timeTableListName[dayIndex][i] != '')
                Container(
                  child: Stack(
                      children:[
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset('assets/image/test.png'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(15.0,10.0,0.0,0.0),
                            child: Text(i.toString(), style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black12,
                              fontSize: 42.0,
                              letterSpacing: 2.0,
                            ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0,20.0,0.0,0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(timeTableListName[dayIndex][i] == null
                                  ? ' '
                                  : timeTableListName[dayIndex][i],
                                style: TextStyle(
                                  fontSize: 27.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              Text(timeTableListPlace[dayIndex][i] == null
                                  ? ' '
                                  : timeTableListPlace[dayIndex][i].substring(1),//因為原資料第一個為空格，故用substring利用移除空格
                                style: TextStyle(
                                  fontSize: 17.0,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                ),
              ),
          ],
        ),
      );
    }
    else {
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

/*之後做為每個教室地點對應的圖片
Image PicSelect(String place){//所有圖片長寬皆為7:2比例
  return image(


  );
}*/
