import 'package:project/models/order_item.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.createdAt,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}