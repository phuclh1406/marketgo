import 'package:matching/data/model/category_detail.dart';
import 'package:matching/data/model/promotion.dart';
import 'package:matching/data/model/store.dart';
import 'package:uuid/uuid.dart';

class Ingredient {
  Uuid id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  int quantitative;
  Store store;
  Promotion promotion;
  CategoryDetail categoryDetail;
  String status;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.quantitative,
    required this.store,
    required this.promotion,
    required this.categoryDetail,
    required this.status,
  });
}
