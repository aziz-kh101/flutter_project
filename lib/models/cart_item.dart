import 'package:project/models/food.dart';

class CartItem {
  final Food food;
  int quantity;
  final double spiceLevel;

  CartItem({
    required this.food,
    required this.quantity,
    required this.spiceLevel,
  });
}