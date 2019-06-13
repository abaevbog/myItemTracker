import 'package:listTracker/scoped_models/connected_model.dart';
import '../models.dart';

mixin UserModel on ConnectedProducts{
  

  void login(String email, String id){
    authenticatedUser = User(id:id, email: email);
  }

}