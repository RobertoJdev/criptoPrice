import 'package:flutter_application_1/model/user_model.dart';

abstract class IdUserRepository{
  Future<List<UserModel>> findAllUsers();  
}