import 'package:flutter/cupertino.dart';
import 'package:project/models/cart_item.dart';
import 'package:project/models/food.dart';

class CartProvider with ChangeNotifier{
  List<CartItem> cartItems = [];

  void addToCart(Food food, int quantity, double spiceLevel){
    cartItems.add(CartItem(food: food, quantity: quantity, spiceLevel: spiceLevel));
    notifyListeners();
  }

  void removeFromCart(int index){
    cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart(){
    cartItems = [];
    notifyListeners();
  }

  List<CartItem> getCartItems(){
    return cartItems;
  }

  double get totalPrice{
    double total = 0;
    for (var item in cartItems) {
      total += item.food.price * item.quantity;
    }
    return total;
  }

  void decrementItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    }
    else {
      cartItems.remove(item);
    }
    notifyListeners();
  }

  void incrementItem(CartItem item) {
    item.quantity++;
    notifyListeners();
  }
}