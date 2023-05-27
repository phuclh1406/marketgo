// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'package:matching/model/user_model.dart';

import '../core/helper/asset_helper.dart';
import 'city_model.dart';
import 'food_model.dart';

List<StoreModel> storesFromJson(dynamic str) {
  if (str == null || str is! Map) {
    return [];
  }

  final rows = str['rows'];
  if (rows == null || rows is! Iterable) {
    return [];
  }

  return List<StoreModel>.from(rows.map((x) => StoreModel.fromJson(x)));
}

class StoreModel {
  late String? storeId;
  late String? storeName;
  late String? address;
  late String? image = AssetHelper.market;
  late UserModel? userModel;
  late CityModel? cityModel;
  late String? status;

  StoreModel({
    this.storeId,
    this.storeName,
    this.address,
    this.userModel,
    this.cityModel,
    this.status,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    address = json['address'];
    userModel = json['store_user'] != null
        ? UserModel.fromJson(json['store_user'])
        : null;
    cityModel = json['store_city'] != null
        ? CityModel.fromJson(json['store_city'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['address'] = address;
    if (userModel != null) {
      data['store_user'] = {
        'user_id': userModel!.id,
        'user_name': userModel!.name,
        'email': userModel!.email,
        'address': userModel!.address,
        'phone': userModel!.phone,
        'role_model': userModel!.roleModel?.toJson(),
      };
    }
    if (cityModel != null) {
      data['store_city'] = {
        'city_id': cityModel!.cityId,
        'city_name': cityModel!.cityName,
      };
    }
    data['status'] = status;
    return data;
  }
}
