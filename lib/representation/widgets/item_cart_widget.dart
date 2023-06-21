import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/model/cart.dart';
import 'package:matching/model/order_detail_model.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../screen/delivery_address.dart';
import 'button_widget.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late List<OrderDetail> listOrder;
  late Cart cart;
  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    listOrder = cart.getListItem();
  }

  Widget _buildSingleCartItem(OrderDetail orderDetail) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tên sản phẩm: ${orderDetail.ingredient!.ingredientName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Text(
                  "Giá: ${orderDetail.price} (vnđ)",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Text(
                  "Định lượng: ${orderDetail.ingredient!.quantitative}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: kDefaultPadding / 3),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (orderDetail.quantity > 1) {
                              orderDetail.quantity -= 1;
                              cart.editItem(
                                  orderDetail.ingredient!.ingredientId!,
                                  orderDetail.quantity);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            FontAwesomeIcons.circleMinus,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1.0,
                          color: Colors.black,
                        )),
                        child: Text(
                          "${orderDetail.quantity}",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (orderDetail.quantity <
                                int.parse(orderDetail.ingredient!.quantity
                                    .toString())) {
                              orderDetail.quantity += 1;
                              cart.editItem(
                                  orderDetail.ingredient!.ingredientId!,
                                  orderDetail.quantity);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            FontAwesomeIcons.circlePlus,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        "Xác nhận xóa sản phẩm ${orderDetail.ingredient!.ingredientName}?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Hủy'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Xóa",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            cart.removeItem(
                                orderDetail.ingredient!.ingredientId!);
                            listOrder.remove(orderDetail);
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.zero,
              child: const Icon(
                FontAwesomeIcons.xmark,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cart.getListItem().isNotEmpty
        ? Column(
            children: [
              ...cart
                  .getListItem()
                  .map((e) => _buildSingleCartItem(e))
                  .toList(),
              ButtonWidget(
                title: "Tiếp tục",
                ontap: () {
                  Navigator.pushNamed(context, DeliveryAddressScreen.routeName);
                },
              ),
            ],
          )
        : const Column(
            children: [
              SizedBox(
                height: 300,
              ),
              Center(
                child: Text(
                  "Giỏ hàng trống",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
  }
}
