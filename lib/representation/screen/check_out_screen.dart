import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/model/cart.dart';
import 'package:matching/model/delivery_form.dart';
import 'package:matching/representation/screen/cart_screen.dart';
import 'package:matching/representation/screen/main_app.dart';
import 'package:matching/representation/screen/success_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:matching/representation/widgets/button_widget.dart';
import 'package:matching/representation/widgets/item_check_out_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/textstyle_constants.dart';
import '../../services/payment_service.dart';
import '../widgets/button_payment_widget.dart';

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

  Future<DeliveryForm?> getDeliveryForm() async {
    DeliveryForm singletonInstance = DeliveryForm.singleton();
    return await singletonInstance.getDeliveryFormFromSharedPreferences();
  }

  Future<void> _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launch(url.toString(),
          forceSafariVC: false, forceWebView: false, universalLinksOnly: true);
      if (url.path == '/success') {
        Navigator.of(context).pushNamed(SuccessScreen.routeName);
      } else {
        Navigator.of(context).pushNamed(CheckOutScreen.routeName);
      }
    } else {
      print('Cannot launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    Cart cart = Cart();
    DeliveryForm? deliveryForm;
    return MiniAppBarContainerWidget(
      implementLeading: true,
      titleString: "Thông tin giao dịch",
      child: Column(
        children: [
          const SizedBox(
            height: kMediumPadding / 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: kMinPadding,
                  ),
                  CheckoutItemWidget(cart: cart),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                              "Địa chỉ giao hàng",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<DeliveryForm?>(
                          future: getDeliveryForm(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DeliveryForm?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              deliveryForm = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tên: ${deliveryForm?.name}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding/2,
                                    ),
                                    Text(
                                      "Số điện thoại: ${deliveryForm?.phone}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding/2,
                                    ),
                                    Text(
                                      "Địa chỉ: ${deliveryForm?.address}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding/2,
                                    ),
                                    Text(
                                      "Thành phố: ${deliveryForm?.city}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding/2,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const Text(
                                "Đã có lỗi xảy ra khi lấy thông tin",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(kMinPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      color: const Color.fromARGB(255, 212, 204, 204)
                          .withOpacity(0.4),
                    ),
                    child: Text(
                      'Số tiền bạn cần thanh toán là: ${cart.totalPrice().toInt()} (vnđ)',
                      style: TextStyles.defaultStyle.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonPaymentWidget(
                    title: "Thanh toán qua thẻ VISA",
                    ontap: () async {
                      String? url = await PaymentService.payment(
                          'Thanh toan hoa don', cart.totalPrice().toDouble());
                      getUserIdFromSharedPreferences().then((userId) {
                        _launchURL(url!);
                        OrderService.createCartOrder(
                                userId!,
                                cart.totalPrice(),
                                deliveryForm!.address,
                                deliveryForm!.city,
                                cart.getListItem())
                            .then((response) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${response['msg']}'),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        });
                      });
                    },
                  ),
                  const SizedBox(height: kDefaultPadding),
                  ButtonWidget(
                    title: "Về trang chủ",
                    ontap: () {
                      Navigator.of(context).pushNamed(MainApp.routeName);
                    },
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
