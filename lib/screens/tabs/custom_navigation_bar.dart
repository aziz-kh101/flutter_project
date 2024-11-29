
import 'package:flutter/material.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/screens/tabs/pages/cart.dart';
import 'package:project/screens/tabs/pages/favorites.dart';
import 'package:project/screens/tabs/pages/home.dart';
import 'package:project/screens/tabs/pages/profile.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  int pageIndex = 0;

  final pages = [
    const Home(),
    const Favorites(),
    const Cart(),
    const Profile(),
  ];

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cartItemsCount = Provider.of<CartProvider>(context).getCartItems().length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        backgroundColor: Colors.white,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: pageIndex,
        onTap: changePage,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(pageIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                cartItemsCount == 0 ? const SizedBox() :
                Positioned(
                  right: -5,
                  top: -13,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )
                    ),
                    child: Text(
                      cartItemsCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
              ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[pageIndex],
      floatingActionButton: pageIndex == 3 || pageIndex == 2 ? null : FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/orders');
        },
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.storage),

      ),
    );
  }
}
