import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/delivery_form.dart';

import 'package:matching/data/model/order_detail.dart';
import 'package:matching/representation/widgets/button_widget.dart';
import 'package:matching/representation/widgets/item_check_out_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/ingredient.dart';
import '../../data/model/order.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const String routeName = "/check-out";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final List<String> listStep = [
    "Delivery",
    "Payment",
    "Confirm",
  ];

  Cart cart = Cart(myCart: HashMap<Uuid, OrderDetail>());

  Widget _buildItemStepCheckout(
      int step, String stepName, bool isEnd, bool isCheck) {
    return Row(
      children: [
        Container(
          width: kMediumPadding,
          height: kMediumPadding,
          decoration: BoxDecoration(
            color: isCheck
                ? ColorPalette.yellowColor
                : ColorPalette.yellowColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(
              kMediumPadding,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: kMinPadding,
        ),
        Text(
          stepName,
          style: const TextStyle(
              color: ColorPalette.yellowColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: kMinPadding,
        ),
        if (!isEnd)
          const SizedBox(
            width: kDefaultPadding,
            child: Divider(
              height: 1,
              thickness: 1,
              color: ColorPalette.yellowColor,
            ),
          ),
        if (!isEnd)
          const SizedBox(
            width: kMinPadding,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //final cart = ModalRoute.of(context)!.settings.arguments as Cart? ?? Cart(myCart: HashMap<Uuid, OrderDetail>());
    final deliveryForm =
        ModalRoute.of(context)!.settings.arguments as DeliveryForm;
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
      implementLeading: true,
      titleString: "Checkout Screen",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listStep
                .map((e) => _buildItemStepCheckout(
                      listStep.indexOf(e) + 1,
                      e,
                      listStep.indexOf(e) == listStep.length - 1,
                      listStep.indexOf(e) == 2,
                    ))
                .toList(),
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kMinPadding,
                  ),
                  Column(
                    children: cart.myCart.values
                        .map(
                          (e) => CheckoutItemWidget(
                              name: e.ingredient!.name,
                              price: e.price,
                              quantity: e.quantity,
                              quantitative: e.ingredient!.quantitative),
                        )
                        .toList(),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              "Delivery info",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${deliveryForm.name}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Phone: ${deliveryForm.phone}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email: ${deliveryForm.email}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Address: ${deliveryForm.address}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "City: ${deliveryForm.city}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Total: ${cart.totalPrice().toInt()} VND',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ButtonWidget(
                    title: "Check out",
                  ),
                  const SizedBox(
                    height: 10,
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
