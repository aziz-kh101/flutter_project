import 'dart:convert';

import 'package:project/helpers/apis.dart';
import 'package:project/helpers/http_client.dart';
import 'package:project/models/order.dart';
import 'package:project/models/order_item.dart';

class _OrderService {
  Future<Order> createOrder(List<OrderItem> orderItems) async {
    var body = {
      'items': orderItems.map((item) => {
        'food': item.food.id,
        'quantity': item.quantity,
        'spicy': item.spicy,
      }).toList()
    };
    print("request body: "+ body.toString());
    final response = await client.post(
        Uri.parse(Apis.orders),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );
    print(response.body);
    return response.statusCode == 201 ? Order.fromJson(jsonDecode(response.body) as Map<String, dynamic>) : throw Exception('Failed to create order');
  }

  Future<List<Order>> getOrders() async {
    final response = await client.get(Uri.parse(Apis.orders));
    return response.statusCode == 200 ? (jsonDecode(response.body) as List).map((order) => Order.fromJson(order)).toList() : [];
  }

  Future<void> deleteOrder(String id) async {
    final response = await client.delete(Uri.parse('${Apis.orders}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}

final orderService = _OrderService();