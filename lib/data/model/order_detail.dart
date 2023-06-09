import 'package:matching/model/ingredient_model.dart';

import 'order.dart';

class OrderDetail {
  String? id;
  Order? order;
  IngredientModel? ingredient;
  int price;
  int quantity;
  String status;

  OrderDetail(
      {required this.id,
      required this.order,
      required this.ingredient,
      required this.price,
      required this.quantity,
      required this.status});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    //print("${id} ${order} ${ingredient?.categoryDetailModel?.categoryModel?.cateId} ${price} ${quantity} ${status}");
    data['id'] = null;
    data['price'] = price;
    data['quantity'] = quantity;
    data['status'] = status;
    data['order'] = order?.toJson();
    if (ingredient != null) {
      data['ingredient'] = ingredient!.toJson();
    }

    return data;
  }
}
