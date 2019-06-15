import 'package:flutter/material.dart';

class CustomRoute<E> extends MaterialPageRoute<E>{
  CustomRoute({WidgetBuilder builder, RouteSettings settings}) : super(builder: builder, settings:settings);

  @override 
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute){
      return child;
    } else {

    }
    return FadeTransition(child: child,opacity: animation,);
  }




}