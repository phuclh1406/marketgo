import 'package:matching/model/city_model.dart';
import 'package:matching/model/user_model.dart';

List<Order> ordersFromJson(dynamic str) =>
    List<Order>.from((str).map((x) => Order.fromJson(x)));

class Order {
  late String? id;
  late UserModel? user;
  late int? totalPrice;
  late DateTime? orderDate;
  late String? address;
  late CityModel? city;
  late String? deliveryStatus;
  late String? status;

  Order(
      {required this.id,
      required this.user,
      required this.totalPrice,
      required this.orderDate,
      required this.address,
      required this.city,
      required this.deliveryStatus,
      required this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['order_id'];
    user = UserModel.fromJson(json['order_user']);
    totalPrice = json['total_price'];
    orderDate = formatDateTime(json['order_date']);
    address = json['address'];
    city = CityModel.fromJson(json['order_city']);
    deliveryStatus = json['delivery_status'];
    status = json['status'];
  }

  DateTime formatDateTime(dynamic date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id.toString();
    data['user'] = user?.toJson();
    data['totalPrice'] = totalPrice;
    data['orderDate'] = orderDate?.toIso8601String();
    data['address'] = address;
    data['city'] = city?.toJson();
    data['deliveryStatus'] = deliveryStatus;
    data['status'] = status;
    return data;
  }
}
