import 'package:flutter/material.dart';
import 'package:udemy_app/scoped_models/main.dart';
import 'dart:async';
import '../models.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  Future _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Delete the item"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: ScopedModelDescendant(
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
                    child: Image.asset(item.imageUrl)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(10),
                  child:Text(item.description, style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                  )),
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text("Delete"),
                    onPressed: () => _showDialog(context))
              ],
            ));})
    );}
}
