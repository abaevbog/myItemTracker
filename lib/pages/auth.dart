import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthPage extends StatefulWidget { 
  final MainModel model;
  AuthPage(this.model);
  final fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

enum Mode { Login, SignUp }

class AuthPageState extends State<AuthPage> {
  String username = '';
  String password = '';
  Mode mode = Mode.Login;
  bool switchVal = false;
  String error = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordCont = TextEditingController();

  @override 
  void initState(){
    super.initState();
    try{
      
      widget.auth.currentUser().then((usr){
        if (usr != null){
          widget.model.login(usr.email,usr.uid);
          Navigator.pushReplacementNamed(context, "/home");
        }
      });
    }catch(e){
      print("something broke");
    }
  }


  Widget buildUsername() {
    return TextFormField(
      validator: (String entered) {
        if (entered.isEmpty) {
          return "Email is required";
        } else {
          return entered.split('@').length != 2 || entered.split('.').length < 2
              ? "Invalid email format"
              : null;
        }
      },
      decoration: InputDecoration(
          fillColor: Colors.white, filled: true, labelText: "Email"),
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
      controller: passwordCont,
      onSaved: (String str) {
        password = str;
      },
    );
  }

  Widget buildPasswordConfirm() {
    return mode == Mode.Login
        ? SizedBox(width: 0, height: 0)
        : TextFormField(
            obscureText: true,
            validator: (String entered) {
              return entered == passwordCont.text
                  ? null
                  : "Passwords don't match";
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: "Repeat password",
            ),
            onSaved: (String str) {
              password = str;
            },
          );
  }

  void _submit(Function login) async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (mode == Mode.Login) {
      try {
        var usr = await widget.auth
            .signInWithEmailAndPassword(email: username, password: password);
        print("Signed in as ${usr.uid}");
        login(username, usr.uid);
        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        AlertDialog(
          title: Text("Wrong username of password"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    } else {
      try{
        var usr = await widget.auth.createUserWithEmailAndPassword(email: username, password: password);
        login(username, usr.uid);
        Navigator.pushReplacementNamed(context, "/home");
      }catch(e){
        AlertDialog(
          title: Text("Registration failed"),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mode.toString().split('.')[1])),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/loading.gif'),
                    SizedBox(
                      height: 10,
                    ),
                    buildUsername(),
                    SizedBox(
                      height: 10,
                    ),
                    buildPassword(),
                    SizedBox(
                      height: 10,
                    ),
                    buildPasswordConfirm(),
                    SwitchListTile(
                      value: switchVal,
                      onChanged: (bool value) {
                        setState(() {
                          switchVal = !switchVal;
                          mode =
                              (mode == Mode.Login ? Mode.SignUp : Mode.Login);
                        });
                      },
                      title: Text("Switch to " +
                          (mode == Mode.Login
                              ? Mode.SignUp.toString().split('.')[1]
                              : Mode.Login.toString().split('.')[1])),
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                          child: Text(mode.toString().split('.')[1]),
                          onPressed: () => _submit(model.login),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
