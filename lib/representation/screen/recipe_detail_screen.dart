import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/screen/recipe_order_screen.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/recipe_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/dash_line_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  static const String routeName = '/recipe_detail_screen';

  const RecipeDetailScreen({
    Key? key,
    required this.recipeModel,
  }) : super(key: key);

  final RecipeModel recipeModel;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ImageHelper.loadFromAsset(
              alignment: Alignment.topCenter,
              AssetHelper.food4,
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
          Positioned(
            top: kMediumPadding * 3,
            right: kMediumPadding,
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
                  FontAwesomeIcons.solidHeart,
                  size: kDefaultPadding,
                  color: Colors.red,
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
                              // Text(
                              //   widget.recipeModel.recipeName,
                              //   style: TextStyles.defaultStyle.fontHeader.bold,
                              // ),
                              const Spacer(),
                              // Text(
                              //   '${widget.recipeModel.price.toString()}.000 vnđ',
                              //   style: TextStyles.defaultStyle.fontHeader.bold,
                              // ),
                              Text(
                                ' /dish',
                                style: TextStyles.defaultStyle.fontCaption,
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          const DashLineWidget(),
                          Text(
                            'Mô tả',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          const SizedBox(height: kDefaultPadding),
                          //Text(widget.recipeModel.location),
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            'Nấu như thế nào?',
                            style: TextStyles.defaultStyle.bold,
                          ),
                          const SizedBox(height: kDefaultPadding),
                          const Text(
                            'Sơ chế chân giò, nạm bò. \n'
                            'Chân giò heo nếu thích nhiều thịt thì chọn chân sau, thích da và gân sần sật thì chọn chân trước, chặt thành những khoanh tròn, rửa sạch. \n\nLuộc chân giò qua nước sôi cho hết chất bẩn sau đó rửa lại bằng nước sạch. \n\nNạm bò rửa sạch, luộc riêng cùng 1/2 củ gừng thái lát cho thơm. \n\nNinh lửa nhỏ khoảng 2 tiếng, dùng đũa xiên thử miếng nạm, nếu xiên qua được là đạt yêu cầu. \n\nĐợi thịt nạm nguội thái miếng mỏng. \n\nHuyết bò hoặc heo có thể mua sẵn hoặc mua huyết về luộc chín, thái miếng vừa ăn. (Lưu ý mua huyết ở những địa chỉ uy tín để đảm bảo an toàn thực phẩm). \n\nNếu không ăn huyết có thể bỏ qua. \n\nChả cua nặn thành từng viên tròn nhỏ thả vào nồi nước luộc nạm, chả nổi lên là đã chín, bạn vớt ra để riêng. \n\nCó thể thay thế chả cua bằng chả bò, chả giò hoặc không cho chả cũng được. \n\nVới 4 cây sả băm nhỏ, còn lại cắt khúc, đập dập. \n\nHành tây chia 2 phần, một nữa cắt đôi, nữa còn lại thái mỏng. \n\nHành lá, mùi tàu, húng quế rửa sạch thái nhỏ. Các loại rau ăn kèm rửa sạch, để ráo nước.',
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
