import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}



 class AuthPageState extends State<AuthPage>{ 
  String username = '';
  String password = '';
  bool switchVal = false;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: ListView(children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: "Username"
          ),
          onChanged: (String str) {
            username = str;
          },
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
          ),
          maxLines: 4,
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
        title: Text("Accept something"),)
        ,
        RaisedButton(
          child: Text("Login"),
          onPressed: () {
          print("$username and $password");
           Navigator.pushReplacementNamed(context,'/home');
          },
        )
      ],

      )
    );
  }

}