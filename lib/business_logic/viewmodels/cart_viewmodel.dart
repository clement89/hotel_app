import 'package:firebase_demo/business_logic/models/dish.dart';
import 'package:flutter/cupertino.dart';

class CartViewModel extends ChangeNotifier {
  List<Dish> cartItems = [];
  void addItem(Dish item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeItem(Dish item) {
    cartItems.remove(item);
    notifyListeners();
  }
}
