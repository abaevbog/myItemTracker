import 'package:flutter/material.dart';

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
  String description ='';
  double price = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child:ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: "Product title"
          ),
          onChanged: (String str) {
            titleVal = str;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Product description"
          ),
          maxLines: 4,
          onChanged: (String str) {
            description = str;
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "Price"
          ),
          keyboardType: TextInputType.number,
          onChanged: (String str) {
            price = double.parse(str);
          },
        ),
        SizedBox(height: 10.0,),
        RaisedButton(
          color: Theme.of(context).accentColor,
          child:Text("Save"),
          onPressed: () {
            final Map<String,dynamic> product = {
              "title": titleVal,
             "description": description, 
             "price": price,
             "image": "assets/food.jpg"}; 
            widget.productCreate(product);
            Navigator.pushReplacementNamed(context, "/");
          },
        )
      ],
    ));
  }
}
