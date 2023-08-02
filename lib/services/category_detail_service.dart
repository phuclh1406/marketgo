import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matching/model/category_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailService {
  static var client = http.Client;

  static Future<List<CategoryDetailModel>?> getAllCategoriesDetailForIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.herokuapp.com/api/v1/categories_detail?cate_id=1f3db210-89c7-4afd-b6e1-5b4be3cdb6b1';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return categoryDetailFromJson(data['categories_detail']);
    } else {
      return null;
    }
  }

  static Future<List<CategoryDetailModel>?> getAllCategoriesDetailForFoods() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.herokuapp.com/api/v1/categories_detail?cate_id=6e3f5b3b-df19-4776-a7cc-92b0a0a3ce1d';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return categoryDetailFromJson(data['categories_detail']);
    } else {
      return null;
    }
  }
}