import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../model/recipe_model.dart';

class RecipeService {
  static var client = http.Client();

  static Future<List<RecipeModel>?> getAllRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    final requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.http(Config.apiURL, Config.recipeAPI);

    var response = await client.get(url, headers: requestHeaders);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(response.body);
      print(recipesFromJson(data["recipes"]));
      return recipesFromJson(data["recipes"]);
    } else {
      return null;
    }
  }
}
