
import 'package:meta/meta.dart';

class Item{
  String uid;
  String title;
  String description;
  String imageUrl;
  String userEmail;
  String userId;
  double price;
  bool isFavorite;

  Item(this.title,this.description,this.imageUrl,this.price,this.userEmail,this.userId,this.uid, {this.isFavorite=false});

  @override 
  String toString() {
    return "title:$title,description:$description,uid:$uid,userEmail:$userEmail,userId:$userId";
  }
}

class User{
  final String id;
  final String email;
  final String password;
  
  User({@required this.id, @required this.email,
    @required this.password,});
}