import 'package:flutter/material.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NID Login"),
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
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "Password",
                  hintText: "Your NID account password or ...",
                ),
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
                onPressed: () {
                  print(account);
                  print(password);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
