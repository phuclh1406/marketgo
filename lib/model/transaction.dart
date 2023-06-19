
import 'package:uuid/uuid.dart';

import 'order_model.dart';

class Transaction {
  Uuid id;
  Order order;
  double price;
  String status;

  Transaction({
      required this.id,
      required this.order,
      required this.price,
      required this.status});
}
