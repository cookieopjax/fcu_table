import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=>runApp(MaterialApp(
  home:Home(),
));

class Home extends StatelessWidget {
  final String host = 'https://jsonplaceholder.typicode.com/posts';
  List datas = [];
  String test = "123";

  getData(){
    http.get(host).then((response){
     datas = jsonDecode(response.body);
     print(datas.ty);

    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child:Text(datas[2]["title"].toString())
        ),
      );
  }
}