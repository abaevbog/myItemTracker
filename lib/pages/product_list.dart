import 'package:flutter/material.dart';
import './product_create.dart';
import '../models.dart';
import "../scoped_models.dart";
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder:
        (BuildContext context, Widget child, ProductsScopedModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(color: Colors.red),
            key: Key(model.products[index].title),
            onDismissed: (DismissDirection dir) {
              model.deleteProduct(index);
            },
            child: Column(children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(model.products[index].imageUrl)),
                title: Text(model.products[index].title),
                subtitle: Text('\$${model.products[index].price.toString()}'),
                trailing: ScopedModelDescendant(builder: (BuildContext context,
                    Widget child, ProductsScopedModel model) {
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      model.selectProduct(index);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductCreatePage();
                      }));
                    },
                  );
                }),
              ),
              Divider(
                color: Colors.black,
              )
            ]),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
