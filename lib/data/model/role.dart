import 'package:uuid/uuid.dart';

class Role {
  Uuid id;
  String name;
  String status;

  Role({
    required this.id,
    required this.name,
    required this.status,
  });
}
