import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _text = '沒有資料';
  void _getData() async {
    String result = 'NULL';
    try {
      Response response =
      await get('https://jsonplaceholder.typicode.com/posts');
      List data = jsonDecode(response.body);
      print(data[0]['title'].runtimeType);
      result = data[0]['title'];
    } catch (exception) {
      result = '接收錯誤';
    }
    setState(() {
      _text = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_text),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _getData,
      ),
    );
  }
}