import 'package:scoped_model/scoped_model.dart';
import 'package:udemy_app/scoped_models/connected_model.dart';
import '../models.dart';

mixin ProductsScopedModel on ConnectedProducts {
  
  bool showFavorites = false;

  List<Item> get products{

    return List.from(productsList);
  }
  int get index {
    return selectedProductIndex;
  }

  Item get selectedProduct{
    return selectedProductIndex == null ? null: productsList[selectedProductIndex];
  }

  void selectProduct(int index){
    selectedProductIndex = index;
    notifyListeners();
  }

  void deleteProduct(int index) {
    products.removeAt(index);
    notifyListeners();
  }

  void updateProduct(String title,String description, String imageUrl, double price, {bool favInput}) {
    final product = products[selectedProductIndex];
    Item updated = Item(title, description,imageUrl, price,product.userEmail, product.userId, isFavorite: favInput ==null? product.isFavorite: favInput);  
    productsList[selectedProductIndex] = updated;
     notifyListeners();
  }

  void changeFavoriteStatus(){
    print("change fav satus");
    final product = products[selectedProductIndex];
    bool current = product.isFavorite;
    updateProduct(product.title, product.description, product.imageUrl, product.price, favInput: !current);
    notifyListeners();
  }

  void changeFavoritesDisplay(){
    showFavorites = !showFavorites;
    notifyListeners();
  }

  List<Item> get displayProducts{
    if (!showFavorites){
      return List.from(products);
    } else {
      return List.from(products.where((Item prd) => prd.isFavorite).toList());
    }
  }
}



