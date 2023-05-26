import 'package:flutter/material.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/data/model/cart.dart';
import 'package:matching/data/model/order_detail.dart';
import '../../core/helper/asset_helper.dart';

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
  late Cart _currentCart;
  late List<OrderDetail> listOrder;

  @override
  void initState() {
    super.initState();
    _currentCart = widget.cart;
    listOrder = _currentCart.getListItem();
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
          Image.asset(
            AssetHelper.imageLogoSplash,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product: ${orderDetail.ingredient!.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Price: ${orderDetail.price} VND",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 13,
                      icon: const Icon(
                        Icons.remove,
                      ),
                      onPressed: () {
                        setState(() {
                          if (orderDetail.quantity > 1) {
                            orderDetail.quantity -= 1;
                            _currentCart.editItem(orderDetail.ingredient!.id,
                                orderDetail.quantity);
                          }
                        });
                      },
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1.0,
                        color: Colors.black,
                      )),
                      child: Text(
                        "${orderDetail.quantity}",
                      ),
                    ),
                    IconButton(
                      iconSize: 13,
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        setState(() {
                          orderDetail.quantity += 1;
                          _currentCart.editItem(
                              orderDetail.ingredient!.id, orderDetail.quantity);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.7),
              shape: BoxShape.circle
            ),
            
            child: IconButton(
              iconSize: 15,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          "Are you sure you want to remove ${orderDetail.ingredient!.name}?"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            setState(() {
                              _currentCart
                                  .removeItem(orderDetail.ingredient!.id);
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
              icon: const Icon(
                size: 20,
                Icons.delete,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listOrder.isNotEmpty
        ? Column(
            children: listOrder.map((e) => _buildSingleCartItem(e)).toList(),
          )
        : const Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Your cart is empty",
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
