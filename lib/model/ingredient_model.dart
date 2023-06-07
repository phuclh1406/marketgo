// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'dart:ffi';

import 'package:matching/model/category_detail_model.dart';
import 'package:matching/model/store_model.dart';

import 'food_model.dart';
import 'image_model.dart';
import 'promotion_model.dart';

List<IngredientModel> ingredientsFromJson(dynamic str) =>
    List<IngredientModel>.from((str).map((x) => IngredientModel.fromJson(x)));

class IngredientModel {
  late String? ingredientId;
  late String? ingredientName;
  late String? description;
  late int? price;
  late int? quantity;
  late String? quantitative;
  late StoreModel? storeModel;
  // late PromotionModel? promotionModel;
  late CategoryDetailModel? categoryDetailModel;
  late List<ImageModel>? ingreImage;
  late String? status;

  IngredientModel({
    this.ingredientId,
    this.ingredientName,
    this.description,
    this.price,
    this.quantity,
    this.quantitative,
    this.storeModel,
    // this.promotionModel,
    this.categoryDetailModel,
    this.ingreImage,
    this.status,
  });

  IngredientModel.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredient_id'];
    ingredientName = json['ingredient_name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    quantitative = json['quantitative'];
    storeModel = json['ingredient_store'] != null
        ? StoreModel.fromJson(json['ingredient_store'])
        : null;
    // promotionModel = json['promotion_model'] != null
    //     ? PromotionModel.fromJson(json['promotion_model'])
    //     : null;
    categoryDetailModel = json['ingredient_cate_detail'] != null
        ? CategoryDetailModel.fromJson(json['ingredient_cate_detail'])
        : null;
    if (json['ingredient_image'] != null && json['ingredient_image'] is List) {
      ingreImage = List<ImageModel>.from(
        json['ingredient_image'].map((x) => ImageModel.fromJson(x)),
      );
    }
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
    if (storeModel != null) {
      data['ingredient_store'] = {
        'store_id': storeModel!.storeId,
        'store_name': storeModel!.storeName,
        'address': storeModel!.address,
      };
    }
    // if (promotionModel != null) {
    //   data['promotion_model'] = promotionModel!.toJson();
    // }
     if (categoryDetailModel != null) {
      data['ingredient_cate_detail'] = {
        'cate_detail_id': categoryDetailModel!.cateDetailId,
        'cate_detail_name': categoryDetailModel!.cateDetailName,
        'cate_id': categoryDetailModel!.categoryModel!.cateId,
      };
    }
    if (ingreImage != null) {
      data['ingredient_image'] = ingreImage!.map((x) => x.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}
