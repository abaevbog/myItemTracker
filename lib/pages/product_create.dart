import 'package:flutter/material.dart';
import '../models.dart';
import "../scoped_models.dart";
import 'package:scoped_model/scoped_model.dart';

class ProductCreatePage extends StatefulWidget {
  ProductCreatePage();

  @override
  State<StatefulWidget> createState() {
    return ProductCreatePageState();
  }
}

class ProductCreatePageState extends State<ProductCreatePage> {
  String titleVal = '';
  String description = '';
  double price = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle({Item product }) {
    return TextFormField(
      initialValue: product != null ? product.title : "",
      decoration: InputDecoration(labelText: "Product title"),
      validator: (String entered) {
        var answer = entered.isEmpty ? "Title is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          titleVal = val;
        });
      },
    );
  }

  Widget _buildDescription({Item product }) {
    return TextFormField(
      initialValue: product != null ? product.description : "",
      decoration: InputDecoration(labelText: "Product description"),
      maxLines: 4,
      validator: (String entered) {
        var answer = entered.isEmpty ? "Description is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          description = val;
        });
      },
    );
  }

  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    try {
      double.parse(s);
    } catch (e) {
      return false;
    }
    return true;
  }

  Widget _buildPrice({Item product }) {
    return TextFormField(
      initialValue:
          product != null ? product.price.toString() : "",
      decoration: InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      validator: (String entered) {
        var answer = !isNumeric(entered) ? "Valid price is required" : null;
        print(answer);
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          price = double.parse(val);
        });
      },
    );
  }

  void _submit(Function addProduct, Function updateProduct, Item selected) {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    final Item product = Item(titleVal, description, "assets/food.jpg", price);
    if (selected == null) {
      addProduct(product);
    } else {
      updateProduct( product);
    }
    Navigator.pushReplacementNamed(context, "/home");
  }

  Widget submitButton() {
    return ScopedModelDescendant<ProductsScopedModel>(builder: 
    (BuildContext context,Widget child, ProductsScopedModel model){
      return RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text("Save"),
        onPressed: () => _submit(model.addProduct, model.updateProduct, model.selectedProduct)
    ); },);
  }

  Widget buildPageContent({Item product }){
        return Container(
        margin: EdgeInsets.all(10.0),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildTitle(product: product),
                    _buildDescription(product: product),
                    _buildPrice(product :product),
                    SizedBox(
                      height: 10.0,
                    ),
                    submitButton()
                  ],
                ))));
  }


  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ProductsScopedModel model) {
            return model.index == null
        ? buildPageContent()
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit product"),
            ),
            body: buildPageContent(product:model.selectedProduct),
          );
          });
  }
}
