import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String username = '';
  String password = '';
  bool switchVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage("assets/background.jpg"))),
            padding: EdgeInsets.all(10),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                   fillColor: Colors.white,
                   filled: true,
                    labelText: "Username"),
                  onChanged: (String str) {
                    username = str;
                  },
                ),
                SizedBox(height: 10,),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Password",
                  ),
                  onChanged: (String str) {
                    password = str;
                  },
                ),
                SwitchListTile(
                  value: switchVal,
                  onChanged: (bool value) {
                    setState(() {
                      switchVal = !switchVal;
                    });
                  },
                  title: Text("Accept something"),
                ),
                RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    print("$username and $password");
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                )
              ],
            )))));
  }
}
