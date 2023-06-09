//ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matching/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  static var client = http.Client;

  static Future<void> payment() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    const url = 'https://market-go.herokuapp.com/api/v1/stripe/create-checkout-session';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return null;
    }
  }
}