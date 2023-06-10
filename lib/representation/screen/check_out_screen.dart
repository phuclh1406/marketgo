import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/delivery_form.dart';

import 'package:matching/representation/widgets/button_widget.dart';
import 'package:matching/representation/widgets/item_check_out_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const String routeName = "/check-out";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  Future<String?> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    final deliveryForm =
        ModalRoute.of(context)!.settings.arguments as DeliveryForm;
    Cart cart = Cart();
    return MiniAppBarContainerWidget(
      implementLeading: true,
      titleString: "Checkout Screen",
      child: Column(
        children: [
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
                  CheckoutItemWidget(cart: cart),
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
                              const SizedBox(
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
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
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
                        ButtonWidget(
                          title: "Confirm",
                          ontap: () {
                            getUserIdFromSharedPreferences().then((userId) => {
                                  OrderService.createCartOrder(
                                          cart.totalPrice().toString(),
                                          userId!,
                                          cart.getListItem())
                                      .then((response) => {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      response['status'] == 200
                                                          ? const Icon(
                                                              FontAwesomeIcons
                                                                  .circleCheck,
                                                              size: 80,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(
                                                              FontAwesomeIcons
                                                                  .xmark,
                                                              size: 80,
                                                              color: Colors.red,
                                                            ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text(
                                                        response['msg'],
                                                        style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    ButtonWidget(
                                                      title: 'Close',
                                                      ontap: () {
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                'main_app',
                                                                (route) =>
                                                                    false);
                                                      },
                                                    )
                                                  ],
                                                );
                                              },
                                            )
                                          })
                                });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
