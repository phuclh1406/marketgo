import 'package:flutter/material.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/image_helper.dart';
import '../../model/store_model.dart';
import 'button_widget.dart';
import 'dash_line_widget.dart';

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({
    Key? key,
    required this.storeModel,
    this.onTap,
  }) : super(key: key);

  final StoreModel storeModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMediumPadding),
        color: ImageHelper.,
      ),
      margin: const EdgeInsets.only(bottom: kMediumPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeModel.storeName!,
                      style: TextStyles.defaultStyle.fontHeader.bold,
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'Address: ${storeModel.address} m2',
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ImageHelper.loadFromAsset(storeModel.image!, radius: BorderRadius.circular(kItemPadding), height: 50, fit: BoxFit.fitHeight),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
