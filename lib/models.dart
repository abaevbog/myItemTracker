
import 'package:meta/meta.dart';

class Item{
  String title;
  String description;
  String imageUrl;
  String userEmail;
  String userId;
  double price;
  bool isFavorite;

  Item(this.title,this.description,this.imageUrl,this.price,this.userEmail,this.userId, {this.isFavorite=false});
}

class User{
  final String id;
  final String email;
  final String password;
  
  User({@required this.id, @required this.email,
    @required this.password,});
}