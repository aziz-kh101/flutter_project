import 'package:flutter/material.dart';
import 'package:project/models/food.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/providers/food_provider.dart';
import 'package:project/widgets/custom_app_bar.dart';
import 'package:project/widgets/custom_slider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String foodId;
  const Details({required this.foodId, super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double spicyValue = 2.0;
  int quantityValue = 1;

  void addToQuantity() {
    setState(() {
      quantityValue++;
    });
  }

  void removeFromQuantity() {
    if (quantityValue > 1) {
      setState(() {
        quantityValue--;
      });
    }
  }

  void changeSpicyValue(double value) {
    setState(() {
      spicyValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context);
    var food = foodProvider.getFoodById(widget.foodId);
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
              leftIcon: const Icon(Icons.arrow_back_ios_new),
              rightIcon: Icon(food.isFavourite ? Icons.favorite : Icons.favorite_border_outlined, color: theme.primaryColor),
              leftIconPressed: () {
                Navigator.pop(context);
              },
              rightIconPressed: () {
                foodProvider.toggleFavourite(food);
              },
          ),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image(image: food.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'roboto')),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 20),
                            Text(food.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF6A6A6A),
                                    fontFamily: 'roboto')),
                            const SizedBox(width: 10),
                            Text('- ${food.timeToCook} min',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF6A6A6A),
                                    fontFamily: 'roboto')),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(food.description,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6A6A6A),
                                fontFamily: 'roboto')),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Spicy',style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w500
                                  )),
                                  CustomSlider(max: 5, value: spicyValue, onChanged: changeSpicyValue, color: theme.primaryColor),
                                  const Row(
                                    children: [
                                      Text('Mild', style: TextStyle(color: Colors.green, fontSize: 14,
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w500),),
                                      Spacer(),
                                      Text('Hot',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontFamily: 'roboto',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Quantity', style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w500
                                  )),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: removeFromQuantity,
                                        icon: const Icon(Icons.remove),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(quantityValue.toString(), style: TextStyle(fontSize: 16, fontFamily: 'roboto')),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        onPressed: addToQuantity,
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            )

                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${food.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'roboto')),
                            ElevatedButton(
                              onPressed: () {
                                cartProvider.addToCart(food, quantityValue, spicyValue);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: const Text('Add to cart',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'roboto')),
                            )
                          ],
                        )
                      ]),
            ),
          )
        ],
      ),
    );
  }
}
