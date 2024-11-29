import 'package:flutter/cupertino.dart';
import 'package:project/models/food.dart';
import 'package:project/services/food_service.dart';

class FoodProvider with ChangeNotifier {
  final List<Food> _foods = [];

  List<Food> getAllFoods() {
    return _foods;
  }

  setFoods(List<Food> foods) {
    _foods.clear();
    _foods.addAll(foods);
    notifyListeners();
  }

  List<Food> getFoodsByCategory(String category) {
    return _foods.where((food) => food.category == category).toList();
  }

  List<Food> getFavoriteFood() {
    return _foods.where((food) => food.isFavourite == true).toList();
  }

  Food getFoodById(String id) {
    return _foods.firstWhere((food) => food.id == id);
  }

  void toggleFavourite(Food food) async {
    await foodService.toggleFavourite(food.id, food.isFavourite);
    food.isFavourite = !food.isFavourite;
    notifyListeners();
  }
}