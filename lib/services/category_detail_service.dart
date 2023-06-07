import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matching/model/category_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailService {
  static var client = http.Client;

  static Future<List<CategoryDetailModel>?> getAllCategoriesDetail() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.cyclic.app/api/v1/categories_detail';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoryDetailFromJson(data['categories']);
    } else {
      return null;
    }
  }
}