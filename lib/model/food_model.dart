// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'dart:ffi';

import 'package:matching/model/category_detail_model.dart';
import 'package:matching/model/user_model.dart';

import '../core/helper/asset_helper.dart';

List<FoodModel> foodsFromJson(dynamic str) =>
    List<FoodModel>.from((str).map((x) => FoodModel.fromJson(x)));

class FoodModel {
  late String? foodId;
  late String? foodName;
  late String? description;
  late String? image;
  late String? quantitative;
  late UserModel? userModel;
  late CategoryDetailModel? categoryDetailModel;
  late String? phone;
  late String? refreshToken;
  late String? status;

  FoodModel({
    this.foodId,
    this.foodName,
    this.description,
    this.image,
    this.quantitative,
    this.userModel,
    this.categoryDetailModel,
    this.phone,
    this.refreshToken,

    this.status,
    
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    foodName = json['food_name'];
    description = json['description'];
    quantitative = json['quantitative'];
    
    userModel = json['user_model'] != null
      ? UserModel.fromJson(json['user_model'])
      : null;
    categoryDetailModel = json['cate_detail_model'] != null
      ? CategoryDetailModel.fromJson(json['cate_detail_model'])
      : null;
    phone = json['phone'];
    refreshToken = json['refresh_token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['food_id'] = foodId;
    data['food_name'] = foodName;
    data['description'] = description;
    data['quantitative'] = quantitative;
    if (userModel != null) {
      data['user_model'] = userModel!.toJson();
    }
    if (categoryDetailModel != null) {
      data['cate_detail_model'] = categoryDetailModel!.toJson();
    }
    data['phone'] = phone;
    data['refresh_token'] = refreshToken;
    data['status'] = status;
    return data;
  }
}
