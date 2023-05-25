import 'package:matching/data/model/category_detail.dart';
import 'package:matching/data/model/promotion.dart';
import 'package:matching/data/model/store.dart';
import 'package:uuid/uuid.dart';

class Ingredient {
  final Uuid id;
  final String? name;
  final String? description;
  final String? image;
  final double? price;
  final int? quantity;
  final String? quantitative;
  final Store? store;
  final Promotion? promotion;
  final CategoryDetail? categoryDetail;
  final String? status;

  Ingredient({
    required this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.quantitative,
    this.store,
    this.promotion,
    this.categoryDetail,
    this.status,
  });

}
