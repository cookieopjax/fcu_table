import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//登入頁面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isVisible = false;//判斷密碼是否可視
  String account;
  String password;

  Future<void> _loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Account', account);
    await prefs.setString('Password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NID登入",),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextField(
                onChanged: (actValue) {
                  account = actValue;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Account",
                  hintText: "Your NID account username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextField(
                onChanged: (pwdValue) {
                  password = pwdValue;
                },
                decoration:InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: _isVisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                  ),
                  // Based on passwordVisible state choose the icon
                  labelText: "Password",
                  hintText: "Your NID account password or ...",
                ),
                obscureText:  !_isVisible,
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: RaisedButton(
                child: Text("Login"),
                onPressed: () async{
                  print(account);
                  print(password);
                  await _loginUser();
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('測試標題'),
        content: const Text('測試內容.....'),
        actions: <Widget>[
          FlatButton(
            child: Text('確定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}//(還沒用到)帳密錯誤警告視窗

