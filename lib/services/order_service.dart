import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/order_model.dart';
import '../model/order_detail_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class OrderService {
  static var client = http.Client();

  static Future<Map<String, dynamic>> createCartOrder(
      String userId,
      int totalPrice,
      String? address,
      String? cityName,
      String? phone,
      List<OrderDetail> listOrderDetail) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = {
      "userId": userId,
      "totalPrice": totalPrice,
      "cityName": cityName,
      "address": address,
      "phone": phone,
      "orderDetails": listOrderDetail.map((detail) => detail.toJson()).toList(),
    };

    const url = 'https://market-go.herokuapp.com/api/v1/order-detail';

    final response = await http.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: jsonEncode(body),
    );

    var data = jsonDecode(response.body);
    return data;
  }

  static Future<List<Order>?> getOrdersByUserId(String? userId) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = 'https://market-go.herokuapp.com/api/v1/orders?userId=$userId';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return ordersFromJson(data['orders']);
    }
    return null;
  }

  static Future<List<OrderDetail>?> getOrderDetailsByOrderId(
      String? orderId) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accesstoken')!;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url =
        'https://market-go.herokuapp.com/api/v1/order-detail?orderId=$orderId';

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return orderDetailsFromJson(data['orderDetails']);
    }
    return null;
  }
}
