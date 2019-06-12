import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildUsername() {
    return TextFormField(
      validator: (String entered) {
        if (entered.isEmpty) {
          return "Username is required";
        } else {
          return entered.split('@').length != 2 || entered.split('.').length < 2
              ? "Invalid email format"
              : null;
        }
      },
      decoration: InputDecoration(
          fillColor: Colors.white, filled: true, labelText: "Username"),
      onSaved: (String str) {
        username = str;
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      obscureText: true,
      validator: (String entered) {
        if (entered.isEmpty) {
          return "Password required";
        }
        return entered.length < 6 ? "Too short password" : null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Password",
      ),
      onSaved: (String str) {
        password = str;
      },
    );
  }

  void _submit(Function login) {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()){
      return;
    }
    login(username,password);
    Navigator.pushReplacementNamed(context, "/home");
  }

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
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Form(
                          key: _formKey,
                            child: Column(
                          children: <Widget>[
                            buildUsername(),
                            SizedBox(
                              height: 10,
                            ),
                            buildPassword(),
                            SwitchListTile(
                              value: switchVal,
                              onChanged: (bool value) {
                                setState(() {
                                  switchVal = !switchVal;
                                });
                              },
                              title: Text("Accept something"),
                            ),
                            ScopedModelDescendant<MainModel>(
                              builder: (BuildContext context, Widget child, MainModel model){
                                return RaisedButton(
                              child: Text("Login"),
                              onPressed: () => _submit(model.login),
                            );
                              } ,
                            )

                          ],
                        )))))));
  }
}
