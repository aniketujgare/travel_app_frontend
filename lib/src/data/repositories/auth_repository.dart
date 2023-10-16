import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_app/src/domain/models/user_model.dart';

class AuthRepository {
  static const storage = FlutterSecureStorage();
  Future<UserModel?> checkAuthState() async {
    return await getUser();
  }

  Future<UserModel?> getUser() async {
    var user = await storage.read(key: 'current_user');
    if (user != null) {
      return userModelFromJson(user);
    } else {
      return null;
    }
  }

  void getStorage() async {
    var user = await storage.readAll();
    debugPrint(user.toString());
  }
  // void saveUserLocally() async {
  //   var user = await storage.write(key: 'current_user', value: value);
  //   debugPrint(user);
  // }
}
