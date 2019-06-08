import 'package:flutter/material.dart';
import '../products_manager.dart';
import './product_setting.dart';


class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold (
        drawer: Drawer(
          child: Column(children: <Widget>[
            AppBar(title: Text("Choose"),
            automaticallyImplyLeading: false,),
            ListTile(
              title: Text("Manage products"),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => ProductSetting()
                ));
              },
            )
          ],),
        ),
        appBar: AppBar(
          title: Text("Kuku"),
        ),
        body: ProductManager({"title":"Chocolate","image": "assets/food.jpg"}),    
      )
      );
  }
  
}