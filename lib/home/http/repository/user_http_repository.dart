import 'dart:convert';

import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/repository/i_user_repository.dart';
import 'package:http/http.dart' as http;

class UserHttpRepository implements IdUserRepository {

  Future<List<UserModel>> findAllUsers() async {
    final response = await http.get('https://632b64491aabd8373985b5c9.mockapi.io/api/vi/user/');
    final responseMap = jsonDecode(response.body);
    responseMap.map<UserModel>((resp){}).toList();
  }
  
}