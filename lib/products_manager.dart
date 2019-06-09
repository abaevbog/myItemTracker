import 'package:flutter/material.dart';
import './products.dart';
import './models.dart';

class ProductManager extends StatelessWidget {
  final List<Item> products;


  ProductManager(this.products);

  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Products(products))
    ]);
  }
}
