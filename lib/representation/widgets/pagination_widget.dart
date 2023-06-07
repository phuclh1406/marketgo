// import 'package:flutter/material.dart';
// import 'package:matching/model/food_model.dart';
// import 'package:matching/services/food_service.dart';

// import '../../model/recipe_model.dart';

// enum loadMoreStatus {INITIAL, LOADING, STABLE}

// class PaginationWidget with ChangeNotifier {
//   late FoodModel? _foodModel;
//   FoodModel? get foodModel => _foodModel;

//   late List<dynamic> _foodList;
//   List<dynamic> get foodList => _foodList;

//   loadMoreStatus _loadMoreStatus = loadMoreStatus.STABLE;
//   getLoadMoreStatus() => _loadMoreStatus;

//   PaginationWidget() {
//     _foodModel = FoodModel();
//     _foodList = List<dynamic>.empty(growable: true);
//   }

//   fetchRecipe(pageNumber) async {
//     _foodModel = await FoodService.getFoodsByPage(pageNumber);

//     if(_foodModel != null) {
//       _foodList.addAll(_foodModel);
//     }
//   }

//   setLoadingState(loadMoreStatus loadMoreStatus) {
//     _loadMoreStatus = loadMoreStatus;
//     notifyListeners();
//   }
// }