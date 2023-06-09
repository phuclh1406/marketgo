import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/helper/asset_helper.dart';
import 'package:matching/data/model/order_detail.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/image_helper.dart';
import '../../data/model/cart.dart';
import '../../model/ingredient_model.dart';

class IngredientItemWidget extends StatelessWidget {
  const IngredientItemWidget(
      {super.key, required this.ingredientModel, this.onTap});

  final IngredientModel ingredientModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Cart cart = Cart();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 3),
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: onTap,
                    child: ingredientModel.ingreImage != null &&
                            ingredientModel.ingreImage!.isNotEmpty &&
                            ingredientModel.ingreImage![0].image != null
                        ? Image.network(
                            ingredientModel.ingreImage![0].image!,
                            width: 70,
                            fit: BoxFit.fitWidth,
                          )
                        : ImageHelper.loadFromAsset(
                            AssetHelper.no_image,
                            width: 70,
                            fit: BoxFit.fitWidth,
                          ), // Replace with the desired widget if the image does not exist
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            ingredientModel.ingredientName!,
                            style: TextStyles.defaultStyle.fontHeader,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(kMinPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kMinPadding),
                              color: const Color.fromARGB(255, 212, 204, 204)
                                  .withOpacity(0.4),
                            ),
                            child: Text(
                              'Phân loại: ${ingredientModel.categoryDetailModel!.cateDetailName!}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Row(
                      children: [
                        const Text('Cửa hàng: ',
                            style: TextStyle(color: Colors.grey)),
                        Flexible(
                          child: Text(
                            ingredientModel.storeModel!.storeName!,
                            style: TextStyles.defaultStyle.regular,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Positioned(
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Add ${ingredientModel.ingredientName} to cart!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              cart.addToCart(OrderDetail(
                                  id: "",
                                  order: null,
                                  ingredient: ingredientModel,
                                  price: ingredientModel.price!,
                                  quantity: 1,
                                  status: "Active"));
                            },
                            child: const Icon(
                              FontAwesomeIcons.circlePlus,
                              color: Colors.amber,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Row(
                      children: [
                        const Text('Giá tiền: ',
                            style: TextStyle(color: Colors.grey)),
                        Text('${ingredientModel.price!.toString()} vnđ',
                            style: TextStyles.defaultStyle.regular),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
