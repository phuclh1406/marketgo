import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/ingredient.dart';
import 'package:matching/data/model/order.dart';
import 'package:matching/data/model/order_detail.dart';
import 'package:matching/representation/screen/delivery_address.dart';
import 'package:matching/representation/widgets/item_cart_widget.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/color_constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/mini_app_bar_container.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Cart cart = Cart(myCart: HashMap<Uuid, OrderDetail>());
    cart.addToCart(
      OrderDetail(
          id: Uuid(),
          order: Order.defaults(),
          ingredient: Ingredient(
            id: const Uuid(),
            name: "Khoai tây",
            description: null,
            image: null,
            price: null,
            quantity: null,
            quantitative: "gram",
            store: null,
            promotion: null,
            categoryDetail: null,
            status: null,
          ),
          price: 32000,
          quantity: 12,
          status: "cart"),
    );
    cart.addToCart(
      OrderDetail(
          id: Uuid(),
          order: Order.defaults(),
          ingredient: Ingredient(
            id: const Uuid(),
            name: "Ca rot",
            description: null,
            image: null,
            price: null,
            quantity: null,
            quantitative: "gram",
            store: null,
            promotion: null,
            categoryDetail: null,
            status: null,
          ),
          price: 20000,
          quantity: 6,
          status: "cart"),
    );
    cart.addToCart(
      OrderDetail(
          id: Uuid(),
          order: Order.defaults(),
          ingredient: Ingredient(
            id: const Uuid(),
            name: "Xương ống",
            description: null,
            image: null,
            price: null,
            quantity: null,
            quantitative: "kg",
            store: null,
            promotion: null,
            categoryDetail: null,
            status: null,
          ),
          price: 12000,
          quantity: 2,
          status: "cart"),
    );
    cart.addToCart(
      OrderDetail(
          id: Uuid(),
          order: Order.defaults(),
          ingredient: Ingredient(
            id: const Uuid(),
            name: "Nấm mèo",
            description: null,
            image: null,
            price: null,
            quantity: null,
            quantitative: "gram",
            store: null,
            promotion: null,
            categoryDetail: null,
            status: null,
          ),
          price: 8500,
          quantity: 10,
          status: "cart"),
    );

    return MiniAppBarContainerWidget(
      titleString: "Your Cart",
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CartItemWidget(
                    cart: cart,
                  ),
                  ButtonWidget(
                    title: "Check out",
                    ontap: () {
                      Navigator.pushNamed(
                          context, DeliveryAddressScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
