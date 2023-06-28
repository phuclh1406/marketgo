import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/model/cart.dart';
import 'package:matching/model/order_detail_model.dart';
import 'package:matching/representation/widgets/button_widget.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../model/ingredient_model.dart';
import '../widgets/dash_line_widget.dart';
import '../widgets/info_ingredient_item_widget.dart';

class IngredientDetailScreen extends StatefulWidget {
  static const String routeName = '/ingredient_detail_screen';

  const IngredientDetailScreen({
    Key? key,
    required this.ingredientModel,
  }) : super(key: key);

  final IngredientModel ingredientModel;

  @override
  State<IngredientDetailScreen> createState() => _IngredientDetailScreenState();
}

class _IngredientDetailScreenState extends State<IngredientDetailScreen> {
  bool isAPICallProcess = false;
  late IngredientModel? ingredientModel;
  late int quantity = 1;
  @override
  void initState() {
    super.initState();
    ingredientModel = widget.ingredientModel;
  }

  @override
  Widget build(BuildContext context) {
    Cart cart = Cart();
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.network(
              alignment: Alignment.topCenter,
              ingredientModel!.ingreImage![0].image!,
              width: 50,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: kMediumPadding * 3,
            left: kMediumPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kDefaultPadding,
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(kItemPadding),
                child: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: kDefaultPadding,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            margin: const EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding * 2),
                topRight: Radius.circular(kDefaultPadding * 2),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: kDefaultPadding),
                  child: Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kItemPadding),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: kMediumPadding),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.ingredientModel.ingredientName!,
                                style: TextStyles.defaultStyle.fontHeader.bold,
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            widget.ingredientModel.description!,
                            style: TextStyles.defaultStyle.subTitleTextColor,
                          ),
                          const DashLineWidget(),
                          Column(children: [
                            IngredientItemDetailWidget(
                                title: 'Tên sản phẩm',
                                description:
                                    widget.ingredientModel.ingredientName!),
                            IngredientItemDetailWidget(
                                title: 'Giá tiền',
                                description:
                                    '${widget.ingredientModel.price!.toString()} (vnđ)'),
                            IngredientItemDetailWidget(
                                title: 'Định lượng',
                                description:
                                    widget.ingredientModel.quantitative!),
                            IngredientItemDetailWidget(
                                title: 'Cửa hàng',
                                description: widget
                                    .ingredientModel.storeModel!.storeName!),
                            IngredientItemDetailWidget(
                                title: 'Phân loại',
                                description: widget.ingredientModel
                                    .categoryDetailModel!.cateDetailName!),
                            IngredientItemDetailWidget(
                                title: 'Số lượng hàng còn',
                                description: widget.ingredientModel.quantity!
                                    .toString()),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity -= 1;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: const Icon(
                                  size: 32,
                                  FontAwesomeIcons.circleMinus,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: kItemPadding,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                "$quantity",
                                style: const TextStyle(fontSize: 23),
                              ),
                            ),
                            const SizedBox(
                              width: kItemPadding,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity <
                                      int.parse(ingredientModel!.quantity
                                          .toString())) {
                                    quantity += 1;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: const Icon(
                                  size: 32,
                                  FontAwesomeIcons.circlePlus,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: const ButtonWidget(
                            title: "Add to cart",
                          ),
                        ),
                        onTap: () {

                          if (cart.getCart()[ingredientModel!.ingredientId] !=
                                  null) {
                                                          int cartQuantity = cart
                              .getCart()[ingredientModel!.ingredientId]!
                              .quantity;
                          int ingredientQuantity =
                              int.parse(ingredientModel!.quantity.toString());
                              if(cartQuantity + quantity > ingredientQuantity){
                                showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Xin lỗi, giỏ hàng của bạn đang có ',
                                          ),
                                          TextSpan(
                                            text:
                                                '${cart.getCart()[ingredientModel!.ingredientId]!.quantity} ${ingredientModel!.ingredientName} ',
                                            style: const TextStyle(
                                                color: Colors.red, fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: 'nên bạn chỉ có thể thêm ',
                                          ),
                                          TextSpan(
                                            text:
                                                '${int.parse(ingredientModel!.quantity.toString()) - cart.getCart()[ingredientModel!.ingredientId]!.quantity} ${ingredientModel!.ingredientName} ',
                                            style: const TextStyle(
                                                color: Colors.blue, fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                'vào giỏ hàng',
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('Quay lại', style: TextStyle(fontSize: 16),),
                                      ),
                                    ],
                                  );
                                });
                              }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Thêm $quantity ${ingredientModel!.ingredientName} vào giỏ hàng'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                            cart.addToCart(OrderDetail(
                                id: null,
                                order: null,
                                ingredient: ingredientModel,
                                price: ingredientModel!.price!,
                                quantity: quantity,
                                status: "Active"));
                          }
                            
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Thêm $quantity ${ingredientModel!.ingredientName} vào giỏ hàng'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                            cart.addToCart(OrderDetail(
                                id: null,
                                order: null,
                                ingredient: ingredientModel,
                                price: ingredientModel!.price!,
                                quantity: quantity,
                                status: "Active"));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: kMediumPadding,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
