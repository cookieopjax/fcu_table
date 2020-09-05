import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';
import 'TimeTables.dart';

class Authentication extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Authentication> {
  Future<bool> _checkUserData() async {
    // await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('Account') != null &&
        prefs.getString('Password') != null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('錯誤${snapshot.error}，請重新安裝'),
              ),
            );
          } else {
            if (snapshot.data == true) {
              return HomePage();
            } else {
              return LoginPage();
            }
          }
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
