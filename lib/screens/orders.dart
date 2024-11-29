import 'package:flutter/material.dart';
import 'package:project/helpers/functions.dart';
import 'package:project/models/order.dart';
import 'package:project/screens/order_details.dart';
import 'package:project/services/order_service.dart';
import 'package:project/widgets/custom_app_bar.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];
  bool isLoaded = false;


  @override
  void initState() {
    super.initState();

    fetchOrders();
  }

  deleteOrder(String id) async {
    await orderService.deleteOrder(id);
    setState(() {
      orders.removeWhere((element) => element.id == id);
    });
  }

  showAlertDialog(String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.red
      ),
      child: const Text("Delete"),
      onPressed:  () {
        deleteOrder(id);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Order"),
      content: const Text("Are you sure you want to delete this order? This action cannot be undone."),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void fetchOrders() async {
    // fetch orders
    final result = await orderService.getOrders();

    setState(() {
      isLoaded = true;
      orders = result;
    });
  }

  double getTotal(Order order) {
    return order.items.fold(0, (total, item) => total + item.food.price * item.quantity);
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(leftIcon: const Icon(Icons.arrow_back_ios_new_outlined), rightIcon: null, leftIconPressed: () => { Navigator.pop(context) }),
          Expanded(
            child: !isLoaded ?
            const Center(
              child: CircularProgressIndicator(),
            ) : orders.isEmpty ?
            const Center(child: Text('No orders found!', style: TextStyle(fontFamily: 'roboto', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)))
                :
            ListView.builder(
              itemCount: orders.length,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemBuilder: (context, index){
                var order = orders[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                    child: Column(
                      children: [
                        Text('Order # ${order.id}', style: const TextStyle(fontFamily: 'roboto', fontSize: 20, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Text('${order.items.length} items', style: const TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.money_outlined, color: Colors.grey),
                                    const SizedBox(width: 10),
                                    const Text('Total:', style: TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 10),
                                    Text('\$${getOrderTotal(order)}', style: const TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                                    const SizedBox(width: 10),
                                    const Text('Date:', style: TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 10),
                                    Text(formatDateTime(order.createdAt), style: const TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(null, color: Colors.grey),
                                    const SizedBox(width: 10),
                                    const Text('Status:', style: TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 10),
                                    Text(order.status, style: const TextStyle(fontFamily: 'roboto', fontSize: 16, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    showAlertDialog(order.id);
                                  },
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                ),
                                IconButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails(order: order)));
                                    },
                                    icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
