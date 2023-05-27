// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'dart:ffi';

import 'package:matching/model/category_detail_model.dart';
import 'package:matching/model/store_model.dart';

import 'food_model.dart';
import 'promotion_model.dart';

List<IngredientModel> ingredientsFromJson(dynamic str) =>
    List<IngredientModel>.from((str).map((x) => IngredientModel.fromJson(x)));

class IngredientModel {
  late String? ingredientId;
  late String? ingredientName;
  late String? description;
  late double? price;
  late int? quantity;
  late double? quantitative;
  late StoreModel? storeModel;
  late PromotionModel? promotionModel;
  late CategoryDetailModel? categoryDetailModel;
  late String? status;

  IngredientModel({
    this.ingredientId,
    this.ingredientName,
    this.description,
    this.price,
    this.quantity,
    this.quantitative,
    this.storeModel,
    this.promotionModel,
    this.categoryDetailModel,
    this.status,
  });

  IngredientModel.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredient_id'];
    ingredientName = json['ingredient_name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    quantitative = json['quantitative'];
    storeModel = json['store_model'] != null
        ? StoreModel.fromJson(json['store_model'])
        : null;
    promotionModel = json['promotion_model'] != null
        ? PromotionModel.fromJson(json['promotion_model'])
        : null;
    categoryDetailModel = json['cate_detail_model'] != null
        ? CategoryDetailModel.fromJson(json['cate_detail_model'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ingredient_id'] = ingredientId;
    data['ingredient_name'] = ingredientName;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['quantitative'] = quantitative;
    if (categoryDetailModel != null) {
      data['cate_detail_model'] = categoryDetailModel!.toJson();
    }
    if (promotionModel != null) {
      data['promotion_model'] = promotionModel!.toJson();
    }
    if (categoryDetailModel != null) {
      data['cate_detail_model'] = categoryDetailModel!.toJson();
    }
    data['status'] = status;
    return data;
  }
}
