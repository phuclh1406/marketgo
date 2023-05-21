import 'package:matching/data/model/food.dart';
import 'package:matching/data/model/ingredient.dart';
import 'package:matching/data/model/user.dart';
import 'package:uuid/uuid.dart';

class Feedback {
  Uuid id;
  String description;
  User user;
  Ingredient ingredient;
  Food food;
  String status;

  Feedback({
    required this.id,
    required this.description,
    required this.user,
    required this.ingredient,
    required this.food,
    required this.status,
  });
}
