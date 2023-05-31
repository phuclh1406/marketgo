import 'package:matching/data/model/category.dart';
import 'package:uuid/uuid.dart';

class CategoryDetail {
  Uuid id;
  String name;
  Category category;
  String status;

  CategoryDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
  });
}
