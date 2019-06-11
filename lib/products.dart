import 'package:flutter/material.dart';
import './models.dart';
import "./scoped_models.dart";
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildProductItem(BuildContext context, int index,List<Item> products) {
    print("build product item");
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset(products[index].imageUrl),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              products[index].title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              products[index].price.toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ]),
        DecoratedBox(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text("Some more details")),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            )),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                color: Colors.blue,
                icon: Icon(Icons.info),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString())),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.favorite),
              onPressed: () {},
            )
          ],
        )
      ],
    ));
  }

  Function buildConnector(List<Item> products){
    print("build connector");
    return (BuildContext context, int index) => _buildProductItem(context,index,products);
  }

  Widget constructItems( List<Item> products) {
    print("construct items");
    return products.length > 0
        ? Column(children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: buildConnector(products),
              itemCount: products.length,
            ))
          ])
        : Column(children: [
            Expanded(
                child: Center(
              child: Text("No products found"),
            ))
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsScopedModel>(builder: (BuildContext context,Widget child, ProductsScopedModel model){
      print("building products");
      return constructItems(model.products);
    },);
  }
}
