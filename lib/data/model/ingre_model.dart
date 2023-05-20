import 'package:uuid/uuid.dart';

class Ingredient {
  String id;
  String name;
  double price;
  int quantity;

  Ingredient({
    String? id,
    required this.name,
    required this.price,
    required this.quantity,
  }) : id = id ?? const Uuid().v4();
}