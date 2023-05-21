import 'package:uuid/uuid.dart';

class Promotion {
  Uuid id;
  String name;
  String description;
  DateTime startTime;
  DateTime endTime;
  double discount;
  String status;

  Promotion({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.discount,
    required this.status,
  });
}
