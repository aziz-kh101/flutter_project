import 'package:flutter/material.dart';
import 'package:project/models/food.dart';
import 'package:project/providers/food_provider.dart';
import 'package:project/screens/details.dart';
import 'package:project/services/food_service.dart';
import 'package:project/widgets/custom_user_avatar.dart';
import 'package:project/widgets/custom_search_bar.dart';
import 'package:project/widgets/food_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var categories = [
    'All',
    'Pizza',
    'Burger',
    'Pasta',
    'Dessert',
  ];

  var selectedCategory = 'All';

  bool dataLoaded = false;

  setCategory(String category){
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var foodProvider = Provider.of<FoodProvider>(context, listen: false);
    var foods = await foodService.getFoods();
    foodProvider.setFoods(foods);
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var foodProvider = Provider.of<FoodProvider>(context);
    List<Food> foods;
    if(selectedCategory == 'All'){
      foods = foodProvider.getAllFoods();
    } else {
      foods = foodProvider.getFoodsByCategory(selectedCategory);
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 20, right: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FoodGo',
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lobster')),
                    Text('Order your favourite food!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6A6A6A),
                            fontFamily: 'poppins')),
                  ],
                ),
                CustomUserAvatar(
                  size: 70,
                  image: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const CustomSearchBar(),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: categories
                    .map(
                      (category) => GestureDetector(
                        onTap: () => setCategory(category),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: (category == selectedCategory)
                                  ? theme.primaryColor
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(category,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: (category == selectedCategory)
                                        ? Colors.white
                                        : const Color(0xFF6A6A6A)))),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 30),
          !dataLoaded ?
          const Center(child: CircularProgressIndicator()) :
          foods.isEmpty ?
          const Center(child: Text('No food available!', style: TextStyle(fontFamily: 'roboto', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey))) : Expanded(child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: foods.length,
                itemBuilder: (context, index){
                  var item = foods[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: FoodCard(image: item.image, name: item.name, price: item.price, isFavourite: item.isFavourite, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Details(foodId: item.id))); }, rating: item.rating),
                  );
                }
            ),
          ),
        ],
    );
  }
}
