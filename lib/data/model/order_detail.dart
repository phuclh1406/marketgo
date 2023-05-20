import 'package:matching/data/model/ingre_model.dart';
import 'package:uuid/uuid.dart';

import 'order.dart';

class OrderDetail {
  String id;
  Order order;
  Ingredient ingredient;
  double price;
  int quantity;
  String status;

  OrderDetail({
    String? id,
    required this.order,
    required this.ingredient,
    required this.price,
    required this.quantity,
    required this.status
  }) : id = id ?? const Uuid().v4();
}
