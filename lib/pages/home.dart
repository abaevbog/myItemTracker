import 'package:flutter/material.dart';
import '../products_manager.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold (
        appBar: AppBar(
          title: Text("Kuku"),
        ),
        body: ProductManager('test test'),    
      )
      );
  }
  
}