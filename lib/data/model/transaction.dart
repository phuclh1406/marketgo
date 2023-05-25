import 'package:matching/data/model/order.dart';
import 'package:uuid/uuid.dart';

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
