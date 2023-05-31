//ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matching/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static var client = http.Client;

  static Future<List<CategoryModel>?> getAllCategories() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.cyclic.app/api/v1/categories';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data['categories']);
    } else {
      return null;
    }
  }
}