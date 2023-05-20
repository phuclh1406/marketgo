import 'package:matching/data/model/order_detail.dart';
import 'package:uuid/uuid.dart';

class Cart {
  String id;
  Map<String, OrderDetail> cart;

  Cart({
    String? id,
    required this.cart,
  }) : id = id ?? const Uuid().v4();

  Map<String, OrderDetail> getCart() {
    return cart;
  }

  void addToCart(OrderDetail order) {
    String id = order.ingredient.id;
    if (cart.containsKey(id)) {
      OrderDetail? existingOrder = cart[id];
      existingOrder?.quantity += order.quantity;
      cart[id] = existingOrder!;
    } else {
      cart[id] = order;
    }
  }

  void removeOrder(String id) {
    if (cart.containsKey(id)) {
      cart.remove(id);
    }
  }

  void updateCart(OrderDetail order) {
    String id = order.id;
    if (cart.containsKey(id)) {
      cart[id] = order;
    }
  }

  double totalPrice() {
    double total = 0;
    for (var element in cart.values) {
      total += element.price * element.quantity;
    }
    return total;
  }
}
