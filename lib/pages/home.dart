import 'package:flutter/material.dart';
import 'package:udemy_app/scoped_models/main.dart';
import '../products.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Choose"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Manage products"),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/admin");
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text("Kuku"), actions: [
        ScopedModelDescendant<MainModel>(builder:
            (BuildContext context, Widget child, MainModel model) {
          return IconButton(
            icon:  Icon(model.showFavorites ? Icons.favorite: Icons.favorite_border),
            onPressed: () {
              model.changeFavoritesDisplay();
            },
          );
        }),
      ]),
      body: Products(),
    );
  }
}
