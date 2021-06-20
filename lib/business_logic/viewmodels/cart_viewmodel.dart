import 'package:firebase_demo/business_logic/models/dish.dart';
import 'package:flutter/cupertino.dart';

class CartViewModel extends ChangeNotifier {
  List<Dish> cartItems = [];
  void addItem(Dish item) {
    ++item.count;

    print(item.count);

    if (!cartItems.contains(item)) {
      cartItems.add(item);
    }
    notifyListeners();
  }

  void removeItem(Dish item) {
    --item.count;
    print(item.count);
    if (item.count == 0) {
      cartItems.remove(item);
    } else {
      int index = cartItems.indexOf(item);
      cartItems[index] = item;
    }
    notifyListeners();
  }

  void placeOrder() {
    cartItems = [];
    notifyListeners();
  }

  int get count {
    int _count = 0;
    cartItems.forEach((dish) {
      _count += dish.count;
    });
    return _count;
  }

  double get total {
    double _total = 0.0;
    cartItems.forEach((dish) {
      _total += dish.price * dish.count;
    });
    return _total;
  }
}
