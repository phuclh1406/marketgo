import 'package:matching/data/model/user.dart';
import 'package:uuid/uuid.dart';

class Order {
  Uuid? id;
  User? user;
  double totalPrice;
  DateTime orderDate;
  String status;

  Order(
      {required this.id,
      required this.user,
      required this.totalPrice,
      required this.orderDate,
      required this.status});

  Order.defaults() :  
        id = null,
        user = null,
        totalPrice = 0,
        orderDate = DateTime.now(),
        status = 'true';
}
