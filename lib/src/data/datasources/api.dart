import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/src/domain/models/destination_model.dart';
import 'package:travel_app/src/domain/models/wishlist_model.dart';

class ApiService {
  static String baseUrl = 'http://192.168.1.37:3000/';
  // static String usersEndpoint = '/users';
  var client = http.Client();

  Future<void> getWishlist() async {
    try {
      var url = Uri.parse('${baseUrl}wishlist/');

      var response = await client.get(url);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        debugPrint('Destination added to wishlist');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> signupUser({required email, required String password}) async {
    try {
      var url = Uri.parse('${baseUrl}user/signup');
      var response =
          await client.post(url, body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        debugPrint('Destination added to wishlist');
        return true;
      }
    } catch (e) {
      debugPrint('Destination added to wishlist');
    }
    return false;
  }

  Future<bool> logInUser({required email, required String password}) async {
    try {
      var url = Uri.parse('${baseUrl}user/login');
      var response =
          await client.post(url, body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        saveUserLocally(jsonDecode(response.body));
        debugPrint('Login Success');
        return true;
      }
    } catch (e) {
      debugPrint('Destination added to wishlist');
    }
    return false;
  }

  Future<WishlistModel?> getWishlistOfUser(String userId) async {
    try {
      var url = Uri.parse('${baseUrl}wishlist/$userId');

      var response = await client.get(url);
      if (response.statusCode == 200) {
        // debugPrint('status 200');
        // print(userId);
        // print(response.body);
        return wishlistModelFromJson(response.body);
      } else if (response.statusCode == 404) {
        debugPrint('Wishlist doesn\'t found');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<DestinationModel>?> getDestinations() async {
    try {
      var url = Uri.parse('${baseUrl}destination/');
      var response = await client.get(url);
      if (response.statusCode == 200) {
        // restaurnatModelFromJson

        return destinationModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> addDestinationToWishlist(
      {required String userId, required String destinationId}) async {
    try {
      debugPrint(userId);
      debugPrint(destinationId);
      var url = Uri.parse('${baseUrl}wishlist/add');
      var response = await client
          .post(url, body: {"userId": userId, "destinationId": destinationId});
      if (response.statusCode == 200) {
        debugPrint('Destination added to wishlist');
        return true;
      } else {
        debugPrint('error');
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> removeDestinationFromWishlist(
      {required String userId, required String destinationId}) async {
    try {
      var url = Uri.parse('${baseUrl}wishlist/remove');
      var response = await client
          .patch(url, body: {"userId": userId, "destinationId": destinationId});
      if (response.statusCode == 200) {
        debugPrint('Destination removed from wishlist');
        return true;
      } else {
        debugPrint('error');
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future saveUserLocally(dynamic user) async {
    try {
      FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'current_user', value: jsonEncode(user));
    } catch (e) {
      // handle errors here or in your providers, I use repository to handle this
    }
  }

  Future getStoredToken(String token) async {
    // get local user
    FlutterSecureStorage storage = FlutterSecureStorage();
    var data = await storage.read(key: 'current_user');
    if (data != null) {
      final user = jsonDecode(data);
      print(user);
    }
  }
  // Future<RestaurnatModel?> getRestaurants() async {
  //   try {
  //     var url = Uri.parse(baseUrl);
  //     var response = await client.get(url);
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       return restaurnatModelFromJson(json);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

  // Future<MenuModel?> getMenu({required String restaurantId}) async {
  //   try {
  //     var url = Uri.parse('$baseUrl/$restaurantId');
  //     var response = await client.get(url);
  //     if (response.statusCode == 200) {
  //       var json = response.body;
  //       return menuModelFromJson(json);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

  Future<void> addMenu(
      {required String restaurantId,
      required Map<String, dynamic> newMenu}) async {
    var url = Uri.parse('$baseUrl/menu/add/$restaurantId');
    // Send a POST request to add the new food item
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newMenu), // Encode the JSON
    );

    if (response.statusCode == 200) {
      debugPrint(newMenu["dishName"] + 'is added in restaruant' + restaurantId);
    } else {
      // If the server did not return a 200 OK response, handle the error
      debugPrint(
          'Failed to add food item. Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }
}
