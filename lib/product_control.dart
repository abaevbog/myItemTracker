import 'package:flutter/material.dart';

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {

  final Function addProduct;
  MyCustomForm(this.addProduct);

  @override
  _MyCustomFormState createState() => _MyCustomFormState(addProduct);
}


// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final Function addProduct;
  _MyCustomFormState(this.addProduct);
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row (children: <Widget> [
        RaisedButton(
              onPressed: () { 
                print(myController.text);
                addProduct(myController.text);
              },
              child: Text("Button")),
      Container(width: 250, height: 50 ,child: TextField(controller: myController, obscureText: false,
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Input:")),margin: EdgeInsets.all(10), )
        ]);
  }
}