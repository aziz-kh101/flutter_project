

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helpers/functions.dart';
import 'package:project/models/order.dart';
import 'package:project/widgets/custom_app_bar.dart';

class OrderDetails extends StatelessWidget {

  final Order order;

  const OrderDetails({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            leftIcon: const Icon(Icons.arrow_back_ios),
            leftIconPressed: () {
              Navigator.of(context).pop();
            },
            rightIcon: const Icon(null),
          ),
          Expanded(
            child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Order Details',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Order ID', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(order.id),
                    ),
                    ListTile(
                      title: const Text('Order Date', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(formatDateTime(order.createdAt)),
                    ),
                    ListTile(
                      title: const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('\$${getOrderTotal(order)}'),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: order.items.length,
                          itemBuilder: (context, index) {
                            var item = order.items[index];
                            return ListTile(
                              title: Text(item.food.name),
                              subtitle: Text('Quantity: ${item.quantity}'),
                              trailing: Text('Spicy: ${item.spicy}'),
                            );
                          },
                        ),
                    ),
                  ],
                )
          ),
        ],
      ),
    );
  }
}
