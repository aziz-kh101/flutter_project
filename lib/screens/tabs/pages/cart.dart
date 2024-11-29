
import 'package:flutter/material.dart';
import 'package:project/models/order_item.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/services/order_service.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cartProvider = Provider.of<CartProvider>(context);
    var cartItems = cartProvider.getCartItems();

    addOrder() async{
      // add order
      if(cartItems.isEmpty){
        return;
      }
      var toaster = ScaffoldMessenger.of(context);
      var order = await orderService.createOrder(cartItems.map((item) => OrderItem(id: null, food: item.food, quantity: item.quantity, spicy: item.spiceLevel)).toList());
      cartProvider.clearCart();
      toaster.showSnackBar(
        const SnackBar(
          content: Text('Order added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    if(cartItems.isEmpty){
      return const Center(
        child: Text('Cart is empty', style: TextStyle(fontFamily: 'roboto', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey))
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Cart',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index){
                      var item = cartItems[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              child: Image(
                                image: item.food.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.food.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '\$${item.food.price}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Spicy Level: ${item.spiceLevel.toStringAsFixed(1)} / 5',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'roboto',
                                            color: Color(0xFF6A6A6A),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                cartProvider.decrementItem(item);
                                              },
                                            ),
                                            Text(
                                              item.quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                cartProvider.incrementItem(item);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                            ),
                ),
              ],
            )
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              ElevatedButton(
                onPressed: addOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('add order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
