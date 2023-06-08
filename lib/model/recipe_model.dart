// user_id, user_name, email, password, birthday, avatar, address, phone, accessChangePassword, refresh_token, role_id, status

import 'food_model.dart';

List<RecipeModel> recipesFromJson(dynamic str) {
  if (str == null || str is! Map) {
    return [];
  }

  final rows = str['rows'];
  if (rows == null || rows is! Iterable) {
    return [];
  }

  return List<RecipeModel>.from(rows.map((x) => RecipeModel.fromJson(x)));
}

class RecipeModel {
  late String? recipeId;
  late String? ingreDes;
  late String? implementGuide;
  late FoodModel? foodModel;
  late String? status;

  RecipeModel({
    this.recipeId,
    this.ingreDes,
    this.implementGuide,
    this.foodModel,
    this.status,
    
  });

  RecipeModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipe_id'];
    ingreDes = json['ingredient_description'];
    implementGuide = json['implementation_guide'];
    foodModel = json['recipe_food'] != null
      ? FoodModel.fromJson(json['recipe_food'])
      : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['recipe_id'] = recipeId;
    data['ingredient_description'] = ingreDes;
    data['implementation_guide'] = implementGuide;
    if (foodModel != null) {
      data['recipe_food'] = {
        'food_id': foodModel!.foodId,
        'food_name': foodModel!.foodName,
        'description': foodModel!.description,
        'image': foodModel!.image,
        'quantitative': foodModel!.quantitative,
        'user_model': foodModel!.userModel?.toJson(),
        'cate_detail_model': foodModel!.categoryDetailModel?.toJson(),
        'phone': foodModel!.phone,
        'refresh_token': foodModel!.refreshToken,
        'status': foodModel!.status,
      };
    }
    data['status'] = status;
    return data;
  }
}
