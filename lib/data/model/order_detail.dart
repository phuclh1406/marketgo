import 'package:matching/data/model/ingredient.dart';
import 'package:uuid/uuid.dart';

import 'order.dart';

class OrderDetail {
  Uuid id;
  Order order;
  Ingredient ingredient;
  double price;
  int quantity;
  String status;

  OrderDetail(
      {required this.id,
      required this.order,
      required this.ingredient,
      required this.price,
      required this.quantity,
      required this.status});
}
