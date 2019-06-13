import 'package:flutter/material.dart';
import './product_create.dart';
import "../scoped_models/main.dart";
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }


}
class ProductListState extends State<ProductListPage>{

  @override
  void initState() {
    widget.model.fetchFromFirebase(forMyList: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder:
        (BuildContext context, Widget child, MainModel model) {
      return model.isLoading ? Center(child: CircularProgressIndicator())   
      : ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(color: Colors.red),
            key: Key(model.products[index].title),
            onDismissed: (DismissDirection dir) {
              model.selectProduct(index);
              model.deleteProduct();
            },
            child: Column(children: [
              ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(model.products[index].imageUrl)),
                title: Text(model.products[index].title),
                subtitle: Text('\$${model.products[index].price.toString()}'),
                trailing: 
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      model.selectProduct(index);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductCreatePage();
                      }));
                    },
                  )
                
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
