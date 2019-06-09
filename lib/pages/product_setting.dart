import 'package:flutter/material.dart';
import './home.dart';
import './product_create.dart';
import './product_list.dart';

class ProductSetting extends StatelessWidget {
  Function addProduct;
  Function deleteProduct;

  ProductSetting(this.addProduct, this.deleteProduct);

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
                ProductCreatePage(addProduct),
                ProductListPage()
              ],
            ),
          ),
        ));
  }
}
