import 'package:scoped_model/scoped_model.dart';
import '../models.dart';
import './scoped_models.dart';

mixin ConnectedProducts on Model{
  List<Item> productsList = [];
  User authenticatedUser;
  int selectedProductIndex;
  void addProduct(String title,String description, String imageUrl, double price){
    Item newItem = Item(title, description, imageUrl, price, authenticatedUser.email, authenticatedUser.id);
    productsList.add(newItem);
    selectedProductIndex = null;
    notifyListeners();
  }
}