import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/model/category_detail_model.dart';
import 'package:matching/model/ingredient_model.dart';
import 'package:matching/representation/screen/ingredient_detail_screen.dart';
import 'package:matching/representation/widgets/ingredient_item_widget.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:matching/services/ingredient_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../services/category_detail_service.dart';
import '../widgets/categories_list_widget.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  static const String routeName = '/ingredients_screen';

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  bool isAPICallProcess = false;
  String query = '';
  String category = '';
  IngredientModel? ingredientModel;
  Widget listIngredients(String value, String category) {
    if (value.isEmpty && category.isEmpty) {
      return FutureBuilder<List<IngredientModel>?>(
        future: IngredientsService.getAllIngredients(),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            IngredientDetailScreen.routeName,
                            arguments: ingredients[i],
                          );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    } else if (value.isNotEmpty && category == null) {
      return FutureBuilder<List<IngredientModel>?>(
        future: IngredientsService.getIngredientsByName(value),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            IngredientDetailScreen.routeName,
                            arguments: ingredients[i],
                          );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    } else if (value.isEmpty) {
      return FutureBuilder<List<IngredientModel>?>(
        future: IngredientsService.getIngredientsByCategory(category),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            IngredientDetailScreen.routeName,
                            arguments: ingredients[i],
                          );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    } else {
      return FutureBuilder<List<IngredientModel>?>(
        future:
            IngredientsService.getIngredientsByNameAndCategory(value, category),
        builder: (BuildContext context,
            AsyncSnapshot<List<IngredientModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<IngredientModel>? ingredients = snapshot.data;

            if (ingredients != null && ingredients.isNotEmpty) {
              return Column(
                children: [
                  for (var i = 0; i < ingredients.length; i++)
                    if (ingredients[i].ingredientName != null ||
                        ingredients[i].ingreImage![0].image != null)
                      IngredientItemWidget(
                        ingredientModel: ingredients[i],
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            IngredientDetailScreen.routeName,
                            arguments: ingredients[i],
                          );
                        },
                      ),
                ],
              );
            } else {
              return const Text('No ingredients found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const SizedBox(); // Return an empty container or widget if data is null
          }
        },
      );
    }
  }

  Widget loadCategories() {
    return FutureBuilder<List<CategoryDetailModel>?>(
      future: CategoryDetailService.getAllCategoriesDetailForFoods(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryDetailModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        } else if (snapshot.hasData) {
          List<CategoryDetailModel>? listCateDetail = snapshot.data!;

          if (listCateDetail.isNotEmpty) {
            return Row(
              children: [
                CategoriesList(
                  cateName: 'Tất cả',
                  ontap: () {
                    setState(() {
                      category = '';
                    });
                  },
                ),
                for (var i = 0; i < listCateDetail.length; i++)
                  if (listCateDetail[i].cateDetailName != null)
                    CategoriesList(
                      cateName: listCateDetail[i].cateDetailName!,
                      ontap: () {
                        setState(() {
                          category = listCateDetail[i].cateDetailId!;
                        });
                      },
                    ),
              ],
            );
          } else {
            return const Text('No category found.');
          }
        } else if (snapshot.hasError) {
          // Display an error message if the future completed with an error
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: 'Danh sách nguyên liệu',
      implementTraling: true,
      implementLeading: true,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          enabled: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm nguyên liệu của bạn',
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.black,
                size: 14,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kItemPadding,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding),
          ),
          style: TextStyles.defaultStyle,
          onChanged: (value) {},
          onSubmitted: (String submitValue) {
            setState(() {
              query = submitValue;
            });
          },
        ),
        const SizedBox(height: kDefaultPadding / 2),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              child: Row(
                children: [
                  loadCategories(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: ProgressHUD(
              inAsyncCall: isAPICallProcess,
              opacity: 0.3,
              key: UniqueKey(),
              child: Column(children: [
                if (query.isEmpty && category.isEmpty)
                  listIngredients('', '')
                else if (query.isNotEmpty && category.isEmpty)
                  listIngredients(query, '')
                else
                  listIngredients(query, category)
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
