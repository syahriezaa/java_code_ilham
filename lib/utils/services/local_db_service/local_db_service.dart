import 'dart:convert';
import 'package:magang/modules/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDbService{
  LocalDbService._();

  ///Set User data
  static Future<void> setUser(User user)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user',json.encode(user.toJson()));
  }
  ///Get User data
  static Future<User?> GetUser(User user)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if(user==null)return null;
    return User.fromJSON(json.decode(user));
  }

  static Future<void>clearUser(User user)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

}