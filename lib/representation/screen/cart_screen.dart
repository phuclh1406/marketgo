import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';

import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/ingredient.dart';
import 'package:matching/data/model/order.dart';
import 'package:matching/data/model/order_detail.dart';
import 'package:matching/representation/screen/check_out_screen.dart';
import 'package:matching/representation/widgets/app_bar_container.dart';
import 'package:matching/representation/widgets/item_cart_widget.dart';

import 'package:uuid/uuid.dart';

import '../../core/constants/color_constants.dart';

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


    return AppBarContainerWidget(
      titleString: "Your Cart",
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 35,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => ColorPalette.yellowColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CheckOutScreen.routeName, arguments: cart);
                },
                child: const Text(
                  "CHECK OUT",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CartItemWidget(
                  cart: cart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
