// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'package:matching/model/food_model.dart';
import 'package:matching/model/ingredient_model.dart';

List<ImageModel> imagesFromJson(dynamic str) =>
    List<ImageModel>.from((str).map((x) => ImageModel.fromJson(x)));

class ImageModel {
  late String? imageId;
  late String? image;
  late IngredientModel? ingredientModel;
  late FoodModel? foodModel;
  late String? phone;
  late String? refreshToken;
  late String? status;

  ImageModel({
    this.imageId,
    this.image,
    this.ingredientModel,
    this.foodModel,
    this.phone,
    this.refreshToken,

    this.status,
    
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    image = json['image'];
    ingredientModel = json['ingredient_model'] != null
      ? IngredientModel.fromJson(json['ingredient_model'])
      : null;
    foodModel = json['food_model'] != null
      ? FoodModel.fromJson(json['food_model'])
      : null;
    phone = json['phone'];
    refreshToken = json['refresh_token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['image'] = image;
    if (ingredientModel != null) {
      data['ingredient_model'] = ingredientModel!.toJson();
    }
    if (foodModel != null) {
      data['food_model'] = foodModel!.toJson();
    }
    data['phone'] = phone;
    data['refresh_token'] = refreshToken;
    data['status'] = status;
    return data;
  }
}
