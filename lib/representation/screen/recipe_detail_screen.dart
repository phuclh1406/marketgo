import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../model/food_model.dart';
import '../../model/guide_step_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/dash_line_widget.dart';
import 'ingredients_screen.dart';

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
  late List<StepModel> stepList;

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
                Flexible(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.foodModel.foodName!,
                                  style: TextStyles.defaultStyle.fontHeader.bold,
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            widget.foodModel.description!,
                            style: TextStyles.defaultStyle.subTitleTextColor,
                          ),
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
                          if (foodModel!.step!.isNotEmpty)
                            for (var i = 0; i < foodModel!.step!.length; i++)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            kDefaultPadding /
                                                                1.5),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    234,
                                                                    154,
                                                                    73)),
                                                    child: Text(
                                                        (i + 1).toString(),
                                                        style: TextStyles
                                                            .defaultStyle
                                                            .whiteTextColor)),
                                                const SizedBox(
                                                    width: kDefaultPadding / 2),
                                                Flexible(
                                                  child: Text(
                                                    foodModel!.step![i]
                                                        .implementationGuide!,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: kMediumPadding / 2),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                      width: kDefaultPadding * 2.4),
                                                  for (var j = 0;
                                                      j <
                                                          foodModel!.step![i]
                                                              .image!.length;
                                                      j++)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .only(
                                                          right: kDefaultPadding /
                                                              2), // Set the desired spacing
                                                      child: Image.network(
                                                        foodModel!.step![i]
                                                            .image![j].image!,
                                                        height: 50,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: kDefaultPadding),
                                ],
                              ),
                          const SizedBox(height: kDefaultPadding),
                          ButtonWidget(
                            title: 'Chuyển tới cửa hàng nguyên liệu',
                            ontap: () {
                              Navigator.of(context)
                                  .pushNamed(IngredientsScreen.routeName);
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
