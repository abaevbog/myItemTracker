import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(products[index]["image"]),
        Padding(
          padding: EdgeInsets.all(10),
          child:Text(products[index]["title"]),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.pushNamed<bool>(
                            context, '/product/' + index.toString()))
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return products.length > 0
        ? ListView.builder(
            itemBuilder: _buildProductItem,
            itemCount: products.length,
          )
        : Center(
            child: Text("No products found"),
          );
  }
}
