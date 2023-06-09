// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matching/model/ingredient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientsService {
  static var client = http.Client();
  void printWrapped(String text) =>
      RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);
  static Future<List<IngredientModel>?> getAllIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.cyclic.app/api/v1/ingredients';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ingredientsFromJson(data["ingredients"]);
    } else {
      return null;
    }
  }

  static Future<List<IngredientModel>?> getIngredientsByName(
      String? query) async {
    List<IngredientModel> result = [];
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.cyclic.app/api/v1/ingredients';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<IngredientModel> ingredients =
          ingredientsFromJson(data["ingredients"]);

      if (query != null && query.isNotEmpty) {
        result = ingredients
            .where((ingredient) => ingredient.ingredientName!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        print(result);
      } else {
        result = ingredients;
      }
    } else {
      return null;
    }

    return result;
  }

  static Future<List<IngredientModel>?> getIngredientsByCategory(
      String? query) async {
    List<IngredientModel>? result = [];
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url =
        'https://market-go.cyclic.app/api/v1/ingredients?cate_detail_id=$query';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<IngredientModel> ingredients =
          ingredientsFromJson(data["ingredients"]);
      print(query);

      if (query != null && query.isNotEmpty) {
        result = ingredients
            .where((ingredient) =>
                ingredient.categoryDetailModel!.cateDetailId!.contains(query))
            .toList();
        print(result);
      } else {
        result = ingredients;
      }
    } else {
      return null;
    }

    return result;
  }

  static Future<List<IngredientModel>?> getIngredientsByNameAndCategory(
      String name, String category) async {
    List<IngredientModel>? result = [];
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = 'https://market-go.cyclic.app/api/v1/ingredients?cate_detail_id=$category';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<IngredientModel> ingredients = ingredientsFromJson(data["ingredients"]);

      if (name.isNotEmpty) {
        result = ingredients
            .where((ingredient) =>
                ingredient.ingredientName!.toLowerCase().contains(name.toLowerCase()))
            .toList();
      } else {
        result = ingredients;
      }
    } else {
      return null;
    }

    return result;
  }
}
