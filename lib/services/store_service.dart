import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/store_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../model/recipe_model.dart';

class StoreService {
  static var client = http.Client();

  static Future<List<StoreModel>?> getAllStores() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    final requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    const url = 'https://market-go.cyclic.app/api/v1/stores';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return storesFromJson(data["stores"]);
    } else {
      return null;
    }
  }
}