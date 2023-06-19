import 'package:matching/model/ingredient_model.dart';

import 'order_model.dart';

List<OrderDetail> orderDetailsFromJson(dynamic str) =>
    List<OrderDetail>.from((str).map((x) => OrderDetail.fromJson(x)));

class OrderDetail {
  late String? id;
  late Order? order;
  late IngredientModel? ingredient;
  late int price;
  late int quantity;
  late String status;

  OrderDetail(
      {required this.id,
      required this.order,
      required this.ingredient,
      required this.price,
      required this.quantity,
      required this.status});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['order_detail_id'];
    order = null;
    ingredient = IngredientModel.fromJson(json['order_detail_ingredient']);
    price = json['price'];
    quantity = json['quantity'];
    status = json['status'];
  }

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
