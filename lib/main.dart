import 'package:flutter/material.dart';
import 'package:listTracker/pages/product.dart';
import 'package:listTracker/pages/product_setting.dart';
import './pages/auth.dart';
import './pages/product_setting.dart';
import './pages/home.dart';
import './pages/product.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/main.dart';
import './custom_route.dart';

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
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        buttonColor: Colors.deepPurple,
      ),
      routes: {
        "/admin": (ctx) => ProductSetting(model),
        "/home": (ctx) => HomePage(model),
        "/": (ctx) => AuthPage(model),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathEls = settings.name.split('/');
        if (pathEls[0] != '') {
          return null;
        }
        if (pathEls[1] == 'product') {
          final int index = int.parse(pathEls[2]);
          return CustomRoute<bool>(
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
