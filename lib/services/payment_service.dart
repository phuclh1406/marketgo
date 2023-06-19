//ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  static var client = http.Client;

  static Future<String?> payment(String title, double price) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      "order_details": [
        {"title": title, "price": price}
      ]
    });

    const url =
        'https://market-go.herokuapp.com/api/v1/stripe/create-checkout-session';
    print(title);
    print(price);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    final responseData = json.decode(response.body);
    final link = responseData['url'];
    final sessionId = responseData['id'];
    print(link);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return link;
    } else {
      return null;
    }
  }
}
