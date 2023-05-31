import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/food_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FoodService {
  static var client = http.Client();

  static Future<List<FoodModel>?> getAllFoods() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.cyclic.app/api/v1/foods';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return foodsFromJson(data["foods"]);
    } else {
      return null;
    }
  }

  static Future<List<FoodModel>?> getFoodsByName(String? query) async {
  List<FoodModel> result = [];
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('accesstoken')!;
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  const url = 'https://market-go.cyclic.app/api/v1/foods';

  final response = await http.get(Uri.parse(url), headers: requestHeaders);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    List<FoodModel> foods = foodsFromJson(data["foods"]);

    if (query != null && query.isNotEmpty) {
      result = foods.where((food) =>
          food.foodName!.toLowerCase().contains(query.toLowerCase())).toList();
          print(result);
    } else {
      result = foods;
    }
  } else {
    return null;
  }

  return result;
}

}
