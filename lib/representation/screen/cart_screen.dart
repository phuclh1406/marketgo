import 'package:flutter/material.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/representation/widgets/item_cart_widget.dart';
import '../widgets/mini_app_bar_container.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      implementLeading: true,
      titleString: "Your Cart",
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CartItemWidget(cart: cart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
