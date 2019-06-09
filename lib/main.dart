import 'package:flutter/material.dart';
import 'package:udemy_app/pages/product.dart';
import 'package:udemy_app/pages/product_setting.dart';
import './pages/auth.dart';
import './pages/product_setting.dart';
import './pages/home.dart';
import './pages/product.dart';
import 'package:flutter/rendering.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: AuthPage(),
      routes: {
        "/admin": (ctx) => ProductSetting(_addProduct, this._deleteProduct),
        "/home": (ctx) => HomePage(_products, _addProduct, _deleteProduct),
        "/": (ctx) => AuthPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathEls = settings.name.split('/');
        if (pathEls[0] != '') {
          return null;
        }
        if (pathEls[1] == 'product') {
          final int index = int.parse(pathEls[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(
                  _products[index]["title"], _products[index]["image"]));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePage(_products, _addProduct, _deleteProduct));
      },
    );
  }
}

void main() {
  debugPaintSizeEnabled=false;
  runApp(MyApp());
  }
