import 'package:scoped_model/scoped_model.dart';
import '../models.dart';
import 'dart:convert';
import 'package:http/http.dart' as client;

mixin ConnectedProducts on Model {
  List<Item> productsList = [];
  User authenticatedUser;
  int selectedProductIndex;

  void addProduct(
      String title, String description, String imageUrl, double price) {
    print("adding");
    Map<String, dynamic> forJson = {
      "title": title,
      "description": description,
      "price": price,
      "email":authenticatedUser.email,
      "userId": authenticatedUser.id,
      "imageUrl":
          "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwigldWB8eTiAhVHdt8KHdweCVYQjRx6BAgBEAU&url=https%3A%2F%2Fwww.theuiaa.org%2Fuiaa%2Fsafe-access-to-the-mountains-of-nepal%2F&psig=AOvVaw2Lcuei8HACWltB1TtzsfwL&ust=1560461169857761"
    };

    client
        .post('https://productlist-6065d.firebaseio.com/products.json',
            body: json.encode(forJson))
        .then((resp) {
      print("in then");
      Map<String, dynamic> response = json.decode(resp.body);
      Item newItem = Item(title, description, imageUrl, price,
          authenticatedUser.email, authenticatedUser.id, response['name']);
      productsList.add(newItem);
      selectedProductIndex = null;
      notifyListeners();
    });
  }
}
