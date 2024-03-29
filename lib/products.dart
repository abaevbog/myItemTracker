import 'package:flutter/material.dart';
import 'package:listTracker/scoped_models/main.dart';
import './models.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildProductItem(
      BuildContext context, int index, List<Item> products) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: Column(
          children: <Widget>[
            Hero(
              tag: products[index].uid,
              child: FadeInImage(
                  image: NetworkImage(products[index].imageUrl),
                  height: 300,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/loading.gif')),
            ),
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
                  child: Text(products[index].userEmail)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text("from: ${products[index].address}"),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.info),
                    onPressed: () {
                      model.selectProduct(index);
                      Navigator.pushNamed<bool>(
                              context, '/product/' + index.toString())
                          .then((_) {
                        model.selectProduct(null);
                      });
                    }),
                IconButton(
                  color: Colors.red,
                  icon: Icon(model.products[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () {
                    model.selectProduct(index);
                    model.changeFavoriteStatus();
                  },
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Function buildConnector(List<Item> products) {
    return (BuildContext context, int index) =>
        _buildProductItem(context, index, products);
  }

  Widget constructItems(List<Item> products) {
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget result = Center(child: Text("No items"));
        if (model.displayProducts.length > 0 && !model.isLoading) {
          result = constructItems(model.displayProducts);
        } else if (model.isLoading) {
          result = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: model.fetchFromFirebase,
          child: result,
        );
      },
    );
  }
}
