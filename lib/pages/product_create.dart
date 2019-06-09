import 'package:flutter/material.dart';
import '../models.dart';

class ProductCreatePage extends StatefulWidget {
  Function productCreate;

  ProductCreatePage(this.productCreate);

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

  Widget _buildTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product title"),
      validator: (String entered) {
        var answer = entered.isEmpty  ? "Title is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          titleVal = val;
        });
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product description"),
      maxLines: 4,
      validator: (String entered) {
        var answer = entered.isEmpty  ? "Description is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          description = val;
        });
      },
    );
  }

  Widget _buildPrice() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      validator: (String entered) {
        var answer = entered.isEmpty  ? "Price is required" : null;
        return answer;
      },
      onSaved: (String val) {
        setState(() {
          price = double.parse(val);
        });
      },
    );
  }

  void _submit() {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()){
      return;
    }
    final Item product = Item(titleVal, description, "assets/food.jpg", price);
    widget.productCreate(product);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
            child: ListView(
          children: <Widget>[
            _buildTitle(),
            _buildDescription(),
            _buildPrice(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Save"),
                onPressed: () => _submit())
          ],
        )));
  }
}
