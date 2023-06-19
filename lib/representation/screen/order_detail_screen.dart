import 'package:flutter/material.dart';
import 'package:matching/core/constants/color_constants.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/order_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/order_detail_model.dart';
import '../../model/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  static const String routeName = "/order-detail";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Order;
    bool isAPICallProcess = false;

    Widget buildSingleOrderDetail(OrderDetail orderDetail) {
      return Column(
        children: [
          Row(
            children: [
              orderDetail.ingredient!.ingreImage != null &&
                      orderDetail.ingredient!.ingreImage!.isNotEmpty &&
                      orderDetail.ingredient!.ingreImage![0].image != null
                  ? Image.network(
                      orderDetail.ingredient!.ingreImage![0].image!,
                      width: 60,
                      height: 60,
                    )
                  : ImageHelper.loadFromAsset(
                      AssetHelper.no_image,
                      width: 60,
                      height: 60,
                    ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      "Sản phẩm: ${orderDetail.ingredient!.ingredientName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    Text(
                      "Định lượng: ${orderDetail.ingredient!.quantitative}  x ${orderDetail.quantity}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    Text(
                      "Giá tiền: ${orderDetail.price} (vnđ)",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kItemPadding / 2,
          ),
          const Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
        ],
      );
    }

    Widget loadOrderDetails() {
      String date =
          "${args.orderDate!.day}/${args.orderDate!.month}/${args.orderDate!.year}";
      return FutureBuilder(
        future: OrderService.getOrderDetailsByOrderId(args.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderDetail>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<OrderDetail>? orderDetails = snapshot.data;
            if (orderDetails != null && orderDetails.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...orderDetails
                      .map((e) => buildSingleOrderDetail(e))
                      .toList(),
                  const SizedBox(
                    height: kItemPadding,
                  ),
                  Text(
                    'Số sản phẩm: ${orderDetails.length}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: kItemPadding,
                  ),
                  Text(
                    "Ngày đặt hàng: $date",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng số tiền',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.yellowColor,
                        ),
                      ),
                      Text(
                        '${args.totalPrice} (vnđ)',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.yellowColor,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          }
          return const Text("Failed to load order details");
        },
      );
    }

    return MiniAppBarContainerWidget(
        titleString: "Order Detail",
        implementLeading: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(kMediumPadding / 2),
                margin: const EdgeInsets.only(bottom: kMediumPadding / 2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Thông tin đơn hàng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: kMediumPadding,
                    ),
                    ProgressHUD(
                      inAsyncCall: isAPICallProcess,
                      opacity: 0.5,
                      key: UniqueKey(),
                      child: Expanded(child: loadOrderDetails()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
