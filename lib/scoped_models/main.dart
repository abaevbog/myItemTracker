import 'package:scoped_model/scoped_model.dart';
import '../models.dart';
import './scoped_models.dart';
import './scoped_user.dart';
import './connected_model.dart';

class MainModel extends Model with ConnectedProducts, UserModel, ProductsScopedModel {

}