import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';

import 'package:matching/data/model/order_detail.dart';
import 'package:matching/representation/widgets/app_bar_container.dart';
import 'package:matching/representation/widgets/item_check_out_widget.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const String routeName = "/check-out";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final List<String> listStep = [
    "Checkout",
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
            color: isCheck ? Colors.white : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(
              kMediumPadding,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: TextStyle(
              color: isCheck ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: kMinPadding,
        ),
        Text(
          stepName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
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
              color: Colors.white,
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
    final cart = ModalRoute.of(context)!.settings.arguments as Cart? ?? Cart(myCart: HashMap<Uuid, OrderDetail>());

    return AppBarContainerWidget(
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
                      listStep.indexOf(e) == 0,
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
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Total Price: ${cart.totalPrice()} VND',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => ColorPalette.yellowColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Code to handle the checkout action
                          },
                          child: const Text(
                            "BUY",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kMediumPadding,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
