import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/food_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FoodService {
  static var client = http.Client();
  late String token = '';

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token')!;
    print(token);
  }

  Future<List<FoodModel>?> getAllFoods() async {
    await getToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': token
    };

    const url = 'https://market-go.cyclic.app/api/v1/foods';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return foodsFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
