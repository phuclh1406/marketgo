
import 'package:matching/model/ingredient_model.dart';

import 'order.dart';

class OrderDetail {
  String? id;
  Order? order;
  IngredientModel ingredient;
  int price;
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
