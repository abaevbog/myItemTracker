import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text("Kuku"),
        ),
        body: Center(
          child: Text("On the Product Page") ,),    
      );
  }

  
}