import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget{
  final String startingProduct;

  ProductManager(this.startingProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager>{

  List<String> _products = [];

  @override
  void initState() {
    _products.add(widget.startingProduct);
    super.initState();
  }

  void _addProducts(String newProduct){
    setState(() {
      _products.add(newProduct);
      print(_products);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Column(children:[ Container(
            child: MyCustomForm(_addProducts),
             margin: EdgeInsets.all(10.0) , 
          )
    , Expanded(child: Products(_products)) ]);
  }
}