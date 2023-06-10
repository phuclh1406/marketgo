// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'package:matching/model/category_detail_model.dart';
import 'package:matching/model/user_model.dart';

import 'guide_step_model.dart';
import 'image_model.dart';

// List<FoodModel> foodsFromJson(dynamic str) {
//   if (str == null || !(str is Map)) {
//     return [];
//   }

//   final rows = str['rows'];
//   if (rows == null || !(rows is Iterable)) {
//     return [];
//   }

//   return List<FoodModel>.from(rows.map((x) => FoodModel.fromJson(x)));
// }

List<FoodModel> foodsFromJson(dynamic str) =>
    List<FoodModel>.from((str).map((x) => FoodModel.fromJson(x)));

class FoodModel {
  late String? foodId;
  late String? foodName;
  late String? description;
  late List<ImageModel>? image;
  late String? quantitative;
  late UserModel? userModel;
  late CategoryDetailModel? categoryDetailModel;
  late String? phone;
  late String? refreshToken;
  late String? ingreDes;
  late List<StepModel>? step;
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
    this.ingreDes,
    this.step,
    this.status,
    
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'];
    foodName = json['food_name'];
    description = json['description'];
    if (json['food_image'] != null && json['food_image'] is List) {
      image = List<ImageModel>.from(
        json['food_image'].map((x) => ImageModel.fromJson(x)),
      );
    }
    quantitative = json['quantitative'];
    
    userModel = json['user_model'] != null
      ? UserModel.fromJson(json['user_model'])
      : null;
    categoryDetailModel = json['food_cate_detail'] != null
      ? CategoryDetailModel.fromJson(json['food_cate_detail'])
      : null;
    phone = json['phone'];
    refreshToken = json['refresh_token'];
    ingreDes = json['ingredient_description'];
    if (json['food_step'] != null && json['food_step'] is List) {
      step = List<StepModel>.from(
        json['food_step'].map((x) => StepModel.fromJson(x)),
      );
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['food_id'] = foodId;
    data['food_name'] = foodName;
    data['description'] = description;
    if (image != null) {
      data['food_image'] = image!.map((x) => x.toJson()).toList();
    }
    if (step != null) {
      data['food_step'] = step!.map((x) => x.toJson()).toList();
    }
    data['quantitative'] = quantitative;
    if (userModel != null) {
      data['user_model'] = userModel!.toJson();
    }
    if (categoryDetailModel != null) {
      data['food_cate_detail'] = {
        'cate_detail_id': categoryDetailModel!.cateDetailId,
        'cate_detail_name': categoryDetailModel!.cateDetailName,
      };
    }
    data['phone'] = phone;
    data['refresh_token'] = refreshToken;
    data['ingredient_description'] = ingreDes;
    data['status'] = status;
    return data;
  }
}
