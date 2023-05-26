import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/core/helper/asset_helper.dart';

class CheckoutItemWidget extends StatelessWidget {
  const CheckoutItemWidget({
    super.key,
    this.name,
    this.price,
    this.quantity,
    this.quantitative,
  });

  final String? name;
  final double? price;
  final int? quantity;
  final String? quantitative;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            kItemPadding,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            AssetHelper.imageLogoSplash,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: kMediumPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product: $name",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Price: $price VND",
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$quantity $quantitative",
              ),
              const SizedBox(
                width: kMediumPadding,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
