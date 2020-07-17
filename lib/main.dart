import 'package:flutter/material.dart';
void main()=>runApp(MaterialApp(
  home:Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text("test"),
      ),
    );
  }
}