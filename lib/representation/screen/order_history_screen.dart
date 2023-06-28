import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/representation/screen/order_detail_screen.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/dismension_constants.dart';
import '../../model/order_model.dart';
import '../../services/order_service.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  static const String routeName = "/order";

  @override
  State<StatefulWidget> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool isAPICallProcess = false;
  Future<String?> getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Widget loadOrders() {
    return FutureBuilder<String?>(
        future: getUserIdFromSharedPreferences(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            String? userId = snapshot.data;
            print(snapshot.data);
            if (userId != null) {
              return FutureBuilder<List<Order>?>(
                future: OrderService.getOrdersByUserId(userId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Order>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    print('12342131213 ${snapshot.data}' );
                    List<Order>? orders = snapshot.data;
                    if (orders != null && orders.isNotEmpty) {
                      return Column(
                        children: orders
                            .map((e) => _buildOrderHistoryItem(e))
                            .toList(),
                      );
                    }
                  }
                  return const Center(
                    child: Text(
                      'Không tìm thấy lịch sử mua hàng',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
            }
          }
          return const Center(
            child: Text('Có lỗi đã xảy ra'),
          );
        });
  }

  Color getColorByDeliveryStatus(String? deliveryStatus) {
    switch (deliveryStatus) {
      case "On Going":
        return Colors.orange;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Widget _buildOrderHistoryItem(Order order) {
    String date =
        "${order.orderDate!.day}/${order.orderDate!.month}/${order.orderDate!.year}";
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(OrderDetailScreen.routeName, arguments: order);
      },
      child: Container(
        padding: const EdgeInsets.all(kMediumPadding / 2),
        margin: const EdgeInsets.only(bottom: kItemPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mã đơn hàng: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                      color: getColorByDeliveryStatus(order.deliveryStatus),
                    ),
                  ),
                  child: Text(
                    "${order.deliveryStatus}",
                    style: TextStyle(
                        fontSize: 15,
                        color: getColorByDeliveryStatus(order.deliveryStatus)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kItemPadding / 2,
            ),
            Text(
              "${order.id}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: kItemPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ngày đặt hàng",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kItemPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng tiền",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.yellowColor,
                  ),
                ),
                Text(
                  "${order.totalPrice} (vnđ)",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.yellowColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: "Lịch sử mua hàng",
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProgressHUD(
              inAsyncCall: isAPICallProcess,
              opacity: 0.5,
              key: UniqueKey(),
              child: Positioned(child: loadOrders()),
            ),
          ],
        ),
      ),
    );
  }
}
