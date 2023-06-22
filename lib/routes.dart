import 'package:flutter/material.dart';
import 'package:matching/representation/screen/cart_screen.dart';
import 'package:matching/representation/screen/delivery_address.dart';
import 'package:matching/representation/screen/ingredient_detail_screen.dart';
import 'package:matching/representation/screen/ingredients_screen.dart';
import 'package:matching/representation/screen/order_detail_screen.dart';
import 'package:matching/representation/screen/order_history_screen.dart';
import 'package:matching/representation/screen/profile.dart';
import 'package:matching/representation/screen/success_screen.dart';
import 'model/ingredient_model.dart';
import 'representation/screen/check_out_screen.dart';
import 'package:matching/representation/screen/home_screen.dart';
import 'package:matching/model/food_model.dart';
import 'package:matching/representation/screen/recipe_detail_screen.dart';
import 'package:matching/representation/screen/recipe_screen.dart';
import 'package:matching/representation/screen/select_ingredients_recipe_screen.dart';
import 'package:matching/representation/screen/store_screen.dart';
import 'representation/screen/profile_screen.dart';
import 'representation/screen/login_screen.dart';
import 'representation/screen/intro_screen.dart';
import 'representation/screen/main_app.dart';
import 'representation/screen/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginPage.routeName: (context) => const LoginPage(),
  CheckOutScreen.routeName: (context) => const CheckOutScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  Profile.routeName: (context) => const Profile(),
  RecipeScreen.routeName: (context) => const RecipeScreen(),
  IngredientsInRecipeScreen.routeName: (context) =>
      const IngredientsInRecipeScreen(),
  DeliveryAddressScreen.routeName: (context) => const DeliveryAddressScreen(),
  StoreScreen.routeName: (context) => const StoreScreen(),
  IngredientsScreen.routeName: (context) => const IngredientsScreen(),
  OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
  OrderDetailScreen.routeName: (context) => const OrderDetailScreen(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RecipeDetailScreen.routeName:
      final dynamic arguments = settings.arguments;
      if (arguments is FoodModel) {
        final FoodModel foodModel = arguments;
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => RecipeDetailScreen(
            foodModel: foodModel,
          ),
        );
      }
      break;
    case IngredientDetailScreen.routeName:
      final dynamic arguments = settings.arguments;
      if (arguments is IngredientModel) {
        final IngredientModel ingredientModel = arguments;
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => IngredientDetailScreen(
            ingredientModel: ingredientModel,
          ),
        );
      }
      break;
    default:
      return null;
  }
  return null;
}
