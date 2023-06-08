import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/order_detail.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class OrderService {
  static var client = http.Client();

  static Future<void> createCartOrder(String totalPrice, String userId,
      List<OrderDetail> listOrderDetail) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = {
      'userId': userId,
      'totalPrice': totalPrice,
      'orderDetails': listOrderDetail,
    };

    const url = 'https://market-go.cyclic.app/api/v1/order-detail';

    final response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = jsonDecode(response.body);
      return data;
    }
  }
}
