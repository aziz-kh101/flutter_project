import 'package:intl/intl.dart';
import 'package:project/models/order.dart';

formatDateTime(DateTime date) {
  return DateFormat("dd/MM/yyyy hh:mm").format(date);
}

double getOrderTotal(Order order) {
  double total = 0;
  for (var item in order.items) {
    total += item.food.price * item.quantity;
  }
  return total;
}