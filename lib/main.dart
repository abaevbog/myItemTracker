import 'package:flutter/material.dart';
import './products_manager.dart';
import './pages/home.dart';
import './pages/auth.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage()
      );
  }


}

void main () => runApp(MyApp());
