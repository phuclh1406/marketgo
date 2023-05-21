import 'package:matching/data/model/city.dart';
import 'package:matching/data/model/user.dart';
import 'package:uuid/uuid.dart';

class Store {
  Uuid id;
  String name;
  String address;
  City city;
  User user;
  String status;

  Store(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.user,
      required this.status});
}
