import 'package:flutter/material.dart';
import './product_create.dart';
import './product_list.dart';
import "../scoped_models/main.dart";
import 'package:scoped_model/scoped_model.dart';
class ProductSetting extends StatelessWidget {
  MainModel model;

  ProductSetting(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text("Choose"),
                  automaticallyImplyLeading: false,
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("All products"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Product Settings"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Create Product",
                  icon: Icon(Icons.create),
                ),
                Tab(text: "My products", icon: Icon(Icons.list))
              ],
            ),
          ),
          body: Center(
            child: TabBarView(
              children: <Widget>[
                ProductCreatePage(),
                ProductListPage(model)
              ],
            ),
          ),
        ));
  }
}
