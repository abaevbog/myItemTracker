import 'package:flutter/material.dart';
import 'package:listTracker/scoped_models/main.dart';
import 'dart:async';
import '../models.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Item item = model.products[index];
      return Scaffold(
        appBar: AppBar(
          title: Text(item.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                child: Image.network(item.imageUrl)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                item.description,
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
