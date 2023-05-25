import 'package:matching/data/model/category_detail.dart';
import 'package:matching/data/model/user.dart';
import 'package:uuid/uuid.dart';

class Food {
  Uuid id;
  String name;
  String description;
  String image;
  int quantitative;
  User user;
  CategoryDetail categoryDetail;
  String status;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.quantitative,
    required this.user,
    required this.categoryDetail,
    required this.status,
  });
}
