import 'package:scoped_model/scoped_model.dart';
import './models.dart';

class ProductsScopedModel extends Model {
  List<Item> _products = [];
  int _selectedProductIndex;

  List<Item> get products{
    print("Get");
    return List.from(_products);
  }
  int get index {
    return _selectedProductIndex;
  }

  Item get selectedProduct{
    return _selectedProductIndex == null ? null: _products[_selectedProductIndex];
  }

  void selectProduct(int index){
    _selectedProductIndex = index;
  }
  void addProduct(Item product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
    _selectedProductIndex = null;
  }

  void updateProduct(Item newItem) {
    _products[_selectedProductIndex] = newItem;
     _selectedProductIndex = null;
  }
}
