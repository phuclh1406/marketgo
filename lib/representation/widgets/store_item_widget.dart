import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        color: Colors.white,
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
                flex: 3,
                child: ImageHelper.loadFromAsset(storeModel.image!,
                    radius: BorderRadius.circular(kItemPadding),
                    width: 150,
                    fit: BoxFit.fitWidth),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeModel.storeName!,
                      style: TextStyles.defaultStyle.fontHeader,
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.locationDot, color: Colors.red, size: kDefaultIconSize),
                        const SizedBox(width: kDefaultPadding / 3),
                        Text(
                          storeModel.address!,
                          style: TextStyles.defaultStyle.light,
                          maxLines: 2,
                        ),
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
