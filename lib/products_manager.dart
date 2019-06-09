import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String,String>> products;
  final Function addProduct;
  final Function deleteProduct;


  ProductManager(this.products, this.addProduct,this.deleteProduct);

  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: MyCustomForm(addProduct),
        margin: EdgeInsets.all(10.0),
      ),
      Expanded(child: Products(products, deleteProduct: deleteProduct))
    ]);
  }
}
