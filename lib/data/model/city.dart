import 'package:uuid/uuid.dart';

class City {
  Uuid id;
  String name;
  String status;

  City({required this.id, required this.name, required this.status});
}
