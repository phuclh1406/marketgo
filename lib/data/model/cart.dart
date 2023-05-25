import 'dart:collection';

import 'package:matching/data/model/order_detail.dart';
import 'package:uuid/uuid.dart';

class Cart {
  HashMap<Uuid, OrderDetail> myCart;

  Cart({
    required this.myCart,
  });

  List<OrderDetail> getListItem() {
    return myCart.values.toList();
  }

  void addToCart(OrderDetail order) {
    if (myCart.containsKey(order.id)) {
      myCart[order.id]!.quantity += order.quantity;
    } else {
      myCart[order.id] = order;
    }
  }

  void removeItem(Uuid id) {
    if (myCart.containsKey(id)) {
      myCart.remove(id);
    }
  }

  void editItem(Uuid id, int quantity) {
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
