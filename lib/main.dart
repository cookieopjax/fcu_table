import 'package:fcutable/TimeTables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:flutter/services.dart';
import 'login_authentication.dart';


void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authentication(),
      routes: {
        '/home':(context)=>HomePage(),
        '/login':(context)=>Authentication(),
      },
    );
  }
}




