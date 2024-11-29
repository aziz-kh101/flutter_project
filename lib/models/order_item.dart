import 'package:project/models/food.dart';

class OrderItem{
  final String? id;
  final Food food;
  final double spicy;
  final int quantity;

  OrderItem({
    required this.id,
    required this.food,
    required this.quantity,
    required this.spicy,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json){
    return OrderItem(
      id: json['id'],
      food: Food.fromJson(json['food']),
      quantity: json['quantity'],
      spicy: (json['spicy'] as num).toDouble(),
    );
  }
}