import 'package:flutter/material.dart';
import '../products_manager.dart';
import '../models.dart';

class HomePage extends StatelessWidget{
  final List<Item> products;
  final Function addProduct;
  final Function deleteProduct;

  HomePage(this.products,this.addProduct,this.deleteProduct);

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
        body: ProductManager(products),    
      );
      
  }
  
}