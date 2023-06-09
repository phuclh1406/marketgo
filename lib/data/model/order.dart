import 'package:matching/model/user_model.dart';
import 'package:uuid/uuid.dart';

class Order {
  Uuid id;
  UserModel user;
  double totalPrice;
  DateTime orderDate;
  String status;

  Order(
      {required this.id,
      required this.user,
      required this.totalPrice,
      required this.orderDate,
      required this.status});

  Map<String, dynamic> toJson() {
  final data = <String, dynamic>{};
  data['id'] = id.toString();
  data['user'] = user.toJson();
  data['totalPrice'] = totalPrice;
  data['orderDate'] = orderDate.toIso8601String();
  data['status'] = status;
  return data;
  }
}
