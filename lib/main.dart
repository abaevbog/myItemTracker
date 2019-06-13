import 'package:flutter/material.dart';
import 'package:udemy_app/pages/product.dart';
import 'package:udemy_app/pages/product_setting.dart';
import './pages/auth.dart';
import './pages/product_setting.dart';
import './pages/home.dart';
import './pages/product.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/main.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    return ScopedModel<MainModel>(child:MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
        buttonColor: Colors.deepPurple,
      ),
      routes: {
        "/admin": (ctx) => ProductSetting(model),
        "/home": (ctx) => HomePage(model),
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
              builder: (BuildContext context) => ProductPage(index));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePage(model));
      },
    ),model: model);
  }
}

void main() {
  debugPaintSizeEnabled=false;
  runApp(MyApp());
  }
