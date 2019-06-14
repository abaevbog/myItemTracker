import 'package:flutter/material.dart';
import 'package:listTracker/scoped_models/main.dart';
import '../models.dart';
import 'package:scoped_model/scoped_model.dart';
import './locationForm.dart';

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
  String address;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle({Item product}) {
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

  Widget _buildDescription({Item product}) {
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

  Widget _buildPrice({Item product}) {
    return TextFormField(
      initialValue: product != null ? product.price.toString() : "",
      decoration: InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      validator: (String entered) {
        var answer = !isNumeric(entered) ? "Valid price is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          price = double.parse(val);
        });
      },
    );
  }

  void _submit(Function addProduct, Function updateProduct,Item selected, User user, Function selectProduct) {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (selected == null) {
      addProduct(titleVal, description, "assets/food.jpg", address, price).then((bool success){
        if (success){
          Navigator.pushReplacementNamed(context, "/home").then((_)=>selectProduct(null));
        } else{
          showDialog(context: context, builder: (BuildContext context){ 
            return AlertDialog(title: Text("Request failed"), actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Ok")
              )
            ],);
          } );
        }
      });
    } else {
      updateProduct(titleVal, description, "assets/food.jpg",address, price).then((_){
        Navigator.pushReplacementNamed(context, "/home").then((_)=>selectProduct(null));
      });
    }
  }

  Widget submitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading? 
          Center(child:CircularProgressIndicator())
          : RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text("Save"),
            onPressed: () => _submit(
                model.addProduct, model.updateProduct,model.selectedProduct, model.authenticatedUser, model.selectProduct));
      },
    );
  }


  void setAddress(String address){
    address = address;
  }

  Widget buildPageContent(User user, {Item product}) {
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
              _buildPrice(product: product),
              SizedBox(
                height: 10.0,
              ),
              //LocationInput(setAddress),
              SizedBox(
                height: 10.0,
              ),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder:
        (BuildContext context, Widget child, MainModel model) {
      return model.index == null
          ? buildPageContent(model.authenticatedUser)
          :Scaffold(
              appBar: AppBar(
                title: Text("Edit product"),
              ),
              body: buildPageContent(model.authenticatedUser, product: model.selectedProduct),
        );
    });
  }
}
