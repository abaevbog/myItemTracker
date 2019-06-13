import 'package:scoped_model/scoped_model.dart';
import 'package:listTracker/scoped_models/connected_model.dart';
import '../models.dart';
import 'package:http/http.dart' as client;
import 'dart:convert';

mixin ProductsScopedModel on ConnectedProducts {
  bool showFavorites = false;

  List<Item> get products {
    return List.from(productsList);
  }

  int get index {
    return selectedProductIndex;
  }

  Item get selectedProduct {
    return selectedProductIndex == null
        ? null
        : productsList[selectedProductIndex];
  }

  void selectProduct(int index) {
    selectedProductIndex = index;
    notifyListeners();
  }

  Future<dynamic>deleteProduct() {
    final product = products[selectedProductIndex];
    productsList.removeAt(selectedProductIndex);
    selectedProductIndex = null;
    isLoading = true;
    notifyListeners();
    return client
        .delete(
            'https://productlist-6065d.firebaseio.com/products/${product.uid}.json')
        .then((_) {
      isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<dynamic> updateProduct(
      String title, String description, String imageUrl, double price,
      {bool favInput}) {
    isLoading = true;
    notifyListeners();
    final product = products[selectedProductIndex];
    favInput = favInput ==null? false:favInput;
    final Map<String, dynamic> updated = {
      "title": title,
      "description": description,
      "price": price,
      "email": authenticatedUser.email,
      "userId": authenticatedUser.id,
      "favorite": favInput,
      "imageUrl":
          "https://uiaa-web.azureedge.net/wp-content/uploads/2017/12/2018_banner.jpg"
    };

    return client
        .put(
            'https://productlist-6065d.firebaseio.com/products/${product.uid}.json',
            body: json.encode(updated))
        .then((resp) {
      Item updatedItem = Item(title, description, imageUrl, price,
          product.userEmail, product.userId, product.uid,
          isFavorite: favInput == null ? product.isFavorite : favInput);
      productsList[selectedProductIndex] = updatedItem;
      notifyListeners();
      isLoading = false;
      selectedProductIndex = null;
      notifyListeners();
    }).catchError((error){
      isLoading = false;
      selectedProductIndex = null;
      notifyListeners();
      return false;
    });
  }

  void changeFavoriteStatus() {
    print("change fav satus");
    final product = products[selectedProductIndex];
    bool current = product.isFavorite;
    updateProduct(
        product.title, product.description, product.imageUrl, product.price,
        favInput: !current);
    notifyListeners();
  }

  void changeFavoritesDisplay() {
    showFavorites = !showFavorites;
    notifyListeners();
  }

  Future<dynamic> fetchFromFirebase() {
    isLoading = true;
    notifyListeners();
    return client
        .get('https://productlist-6065d.firebaseio.com/products.json')
        .then((resp) {
      Map<String, dynamic> response = json.decode(resp.body);
      final List<Item> items = [];
      print(response);
      if (response == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      response.forEach((String key, dynamic data) {
        Item newItem = Item(
            data['title'],
            data['description'],
            data['imageUrl'],
            data['price'],
            data['email'],
            data['userId'],
            key, isFavorite: data['favorite']);
        items.add(newItem);
      });
      productsList = items;
      isLoading = false;
      selectedProductIndex = null;
      notifyListeners();
    }).catchError((error){
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  List<Item> get displayProducts {
    if (!showFavorites) {
      return List.from(products);
    } else {
      return List.from(products.where((Item prd) => prd.isFavorite).toList());
    }
  }
}
