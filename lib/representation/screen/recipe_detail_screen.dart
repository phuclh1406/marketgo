import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/recipe_order_screen.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../model/food_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/dash_line_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  static const String routeName = '/recipe_detail_screen';

  const RecipeDetailScreen({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  final FoodModel foodModel;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  
  bool isAPICallProcess = false;

  late FoodModel? foodModel;

  @override
  void initState() {
    super.initState();
    foodModel = widget.foodModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Image.network(
              alignment: Alignment.topCenter,
              foodModel!.image![0].image!,
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
                                widget.foodModel.foodName!,
                                style: TextStyles.defaultStyle.fontHeader.bold,
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          const DashLineWidget(),
                          Text(
                            'Nguyên liệu cần thiết',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Text(widget.foodModel.ingreDes!),
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            'Nấu như thế nào?',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            foodModel!.implementGuide !,
                          ),
                          const SizedBox(height: kDefaultPadding),
                          ButtonWidget(
                            title: 'Chuyển tới cửa hàng và nguyên liệu',
                            ontap: () {
                              Navigator.of(context)
                                  .pushNamed(RecipeOrderScreen.routeName);
                            },
                          ),
                          const SizedBox(height: kMediumPadding),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
