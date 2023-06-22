import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../model/city_model.dart';

class CityService {
  static Future<List<CityModel>?> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = 'https://market-go.herokuapp.com/api/v1/cities';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return citiesFromJson(data['cities']);
    }
    return null;
  }
}
