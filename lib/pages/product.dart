import 'package:flutter/material.dart';
import 'package:listTracker/scoped_models/main.dart';
import '../models.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Item item = model.products[index];
      return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 256.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(model.products[index].title),
                  background: Hero(
                    tag: model.products[index].uid,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    alignment: Alignment.center,
                    child: Text(item.address),),
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      item.description,
                      style:
                          TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    ),
                  ),
                ]),
              )
            ],
          ),
          floatingActionButton: ProductFab(item));
    });
  }
}

class ProductFab extends StatefulWidget {
  final Item currentProduct;
  ProductFab(this.currentProduct);
  @override
  State<StatefulWidget> createState() {
    return ProductFabState();
  }
}

class ProductFabState extends State<ProductFab> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 70,
            width: 55,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(0.0, 1.0, curve: Curves.easeIn)),
              child: FloatingActionButton(
                mini: true,
                heroTag: 'contact',
                onPressed: () async {
                  print("call to url launcher");
                  /*final url = 'mailto:${widget.currentProduct.userEmail}';
                if( await canLaunch(url) ){
                  await launch(url);
                } else {
                  throw("Could not launch");
                }*/
                },
                child: Icon(Icons.mail),
              ),
            ),
          ),
          Container(
            height: 70,
            width: 55,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(0.0, 0.5, curve: Curves.easeIn)),
              child: FloatingActionButton(
                heroTag: 'favorite',
                mini: true,
                onPressed: () {
                  model.changeFavoriteStatus();
                },
                child: Icon(
                  widget.currentProduct.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: "options",
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.rotationZ(_controller.value * 3.14 / 2),
                    child: Icon(_controller.isDismissed
                        ? Icons.more_horiz
                        : Icons.close),
                  );
                }),
          ),
        ],
      );
    });
  }
}
