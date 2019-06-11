import 'package:flutter/material.dart';
import '../products.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        drawer: Drawer(
          child: Column(children: <Widget>[
            AppBar(title: Text("Choose"),
            automaticallyImplyLeading: false,),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Manage products"),
              onTap: () {
                Navigator.pushReplacementNamed(context,"/admin");
              },
            )
          ],),
        ),
        appBar: AppBar(
          title: Text("Kuku"),
        ),
        body: Products(),    
      );
      
  }
  
}