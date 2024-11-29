import 'package:flutter/material.dart';
import 'package:project/providers/food_provider.dart';
import 'package:project/screens/details.dart';
import 'package:project/widgets/food_card.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    var favoriteFoods = Provider.of<FoodProvider>(context).getFavoriteFood();
    if(favoriteFoods.isEmpty){
      return const Center(child: Text('No favorite food yet!', style: TextStyle(fontFamily: 'roboto', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)));
    }
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: favoriteFoods.length,
                      itemBuilder: (context, index){
                        var item = favoriteFoods[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: FoodCard(image: item.image, name: item.name, price: item.price, isFavourite: item.isFavourite, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Details(foodId: item.id))); }, rating: item.rating),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}
