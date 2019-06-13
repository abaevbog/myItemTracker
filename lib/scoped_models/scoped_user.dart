import 'package:scoped_model/scoped_model.dart';
import 'package:listTracker/scoped_models/connected_model.dart';
import '../models.dart';

mixin UserModel on ConnectedProducts{
  

  void login(String email, String password){
    authenticatedUser = User(id: "id", email: email, password: password);
  }

}