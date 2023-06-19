import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DeliveryForm {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;

  DeliveryForm(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.city});

  static final DeliveryForm _singleton = DeliveryForm(
    name: null,
    email: null,
    phone: null,
    address: null,
    city: null,
  );

  factory DeliveryForm.singleton() {
    return _singleton;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    return data;
  }

  DeliveryForm.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
  }

  void saveDeliveryFormToSharedPreferences(DeliveryForm deliveryForm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(deliveryForm.toJson());
    prefs.setString('delivery_form', json);
  }

  Future<DeliveryForm?> getDeliveryFormFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('delivery_form');
    if (json != null) {
      Map<String, dynamic> jsonData = jsonDecode(json);
      return DeliveryForm.fromJson(jsonData);
    }
    return null;
  }
}
