import 'package:flutter/material.dart';
import '../products_manager.dart';
import './product_setting.dart';


class HomePage extends StatelessWidget{
  final List<Map<String,String>> products;
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
        body: ProductManager(products,addProduct,deleteProduct),    
      );
      
  }
  
}