import 'package:matching/data/model/food.dart';
import 'package:uuid/uuid.dart';

class Recipe {
  Uuid id;
  String ingredientDescription;
  String implementation;
  Food food;
  String status;

  Recipe({
    required this.id,
    required this.ingredientDescription,
    required this.implementation,
    required this.food,
    required this.status,
  });
}
