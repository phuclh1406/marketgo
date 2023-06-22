import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/core/helper/asset_helper.dart';
import 'package:matching/model/cart.dart';
import 'package:matching/model/order_detail_model.dart';

import '../../core/helper/image_helper.dart';

class CheckoutItemWidget extends StatelessWidget {
  const CheckoutItemWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  Widget _buildSingleCheckoutItem(OrderDetail orderDetail) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          orderDetail.ingredient!.ingreImage != null &&
                  orderDetail.ingredient!.ingreImage!.isNotEmpty &&
                  orderDetail.ingredient!.ingreImage![0].image != null
              ? Image.network(
                  orderDetail.ingredient!.ingreImage![0].image!,
                  width: 80,
                  height: 80,
                )
              : ImageHelper.loadFromAsset(
                  AssetHelper.no_image,
                  width: 80,
                  height: 80,
                ),
          const SizedBox(
            width: kMediumPadding,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.fade,
                  "Tên sản phẩm: ${orderDetail.ingredient!.ingredientName}",
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Text(
                  "Giá tiền: ${orderDetail.price} (vnđ)",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Text(
                  "Số lượng: ${orderDetail.quantity}\nĐịnh lượng: ${orderDetail.ingredient!.quantitative}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: kMediumPadding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          cart.getListItem().map((e) => _buildSingleCheckoutItem(e)).toList(),
    );
  }
}
