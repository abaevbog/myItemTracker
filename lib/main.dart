import 'package:flutter/material.dart';
import './products_manager.dart';
import './pages/home.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
      );
  }


}

void main () => runApp(MyApp());
