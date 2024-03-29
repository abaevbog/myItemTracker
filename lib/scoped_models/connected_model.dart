import 'package:scoped_model/scoped_model.dart';
import '../models.dart';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

mixin ConnectedProducts on Model {
  List<Item> productsList = [];
  User authenticatedUser;
  int selectedProductIndex;
  bool isLoading = false;

  Future<bool> addProduct(String title, String description, String imageUrl,
      String address, File img, double price) async {
    isLoading = true;
    notifyListeners();
    final fileName = 'user/${authenticatedUser.id}/img/${DateTime.now()}.jpg';
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      img,
      StorageMetadata(),
    );
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String imgUrl = dowurl.toString();

      Map<String, dynamic> forJson = {
        "title": title,
        "description": description,
        "price": price,
        "email": authenticatedUser.email,
        "userId": authenticatedUser.id,
        "favorite": false,
        "address": address,
        "imageUrl":imgUrl
      };

      return client
          .post('https://productlist-6065d.firebaseio.com/products.json',
              body: json.encode(forJson))
          .then((resp) {
        if (resp.statusCode != 201 && resp.statusCode != 200) {
          return false;
        }
        Map<String, dynamic> response = json.decode(resp.body);
        if (response == null) {
          isLoading = false;
          notifyListeners();
          return true;
        }
        Item newItem = Item(
            title,
            description,
            imageUrl,
            price,
            authenticatedUser.email,
            authenticatedUser.id,
            address,
            response['name']);
        productsList.add(newItem);
        selectedProductIndex = null;
        isLoading = false;
        notifyListeners();
        return true;
      }).catchError((error) {
        isLoading = false;
        selectedProductIndex = null;
        notifyListeners();
        return false;
      });
  }
}
