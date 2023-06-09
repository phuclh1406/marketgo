import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/delivery_form.dart';
import 'package:matching/representation/screen/card_form_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:matching/representation/widgets/button_widget.dart';
import 'package:matching/representation/widgets/item_check_out_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/payment_service.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const String routeName = "/check-out";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String userId = '';
  final List<String> listStep = [
    "Delivery",
    "Payment",
    "Confirm",
  ];

  @override
  void initState() {
    super.initState();
    _retrieveUserId();
  }

  Future<void> _retrieveUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('user_id');
    setState(() {
      userId = storedUserId ?? '';
    });
  }

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
              fontSize: 16,
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

  _launchURL(String link) async {
   final Uri url = Uri.parse(link);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                              name: e.ingredient.ingredientName,
                              price: e.price,
                              quantity: e.quantity,
                              quantitative: e.ingredient.quantitative),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                  Text(
                    'Total: ${cart.totalPrice().toInt()} VND',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                      title: "Check out",
                      ontap: () async {
                        [
                          {OrderService.createCartOrder(
                              cart.totalPrice().toString(),
                              userId,
                              cart.myCart.values.toList())},
                          {
                            _launchURL(PaymentService.payment().toString())
                          }
                        ];
                      }),
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
