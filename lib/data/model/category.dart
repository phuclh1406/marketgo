import 'package:uuid/uuid.dart';

class Category {
  Uuid id;
  String name;
  String status;

  Category({
    required this.id,
    required this.name,
    required this.status,
  });
}
