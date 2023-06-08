import 'dart:collection';
import 'package:matching/data/model/order_detail.dart';

class Cart {
  static final Cart _instance = Cart._internal();

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  HashMap<String, OrderDetail> myCart = HashMap<String, OrderDetail>();

  HashMap<String, OrderDetail> getCart() {
    return myCart;
  }

  List<OrderDetail> getListItem() {
    return myCart.values.toList();
  }

  void addToCart(OrderDetail orderDetail) {
    if (myCart.containsKey(orderDetail.ingredient.ingredientId)) {
      myCart[orderDetail.ingredient.ingredientId]!.quantity +=
          orderDetail.quantity;
    } else {
      myCart[orderDetail.ingredient.ingredientId!] = orderDetail;
    }
  }

  void removeItem(String id) {
    if (myCart.containsKey(id)) {
      myCart.remove(id);
    }
  }

  void editItem(String id, int quantity) {
    if (myCart.containsKey(id)) {
      myCart[id]!.quantity = quantity;
    }
  }

  double totalPrice() {
    double total = 0;
    for (var element in myCart.values) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
