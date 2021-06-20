import 'package:firebase_demo/business_logic/models/addon.dart';

class Dish {
  final String id;
  final String name;
  final String image;
  final double price;
  final String currency;
  final double calories;
  final String description;
  final bool availability;
  final int type;
  final String nextUrl;
  final List<Addon> addonCat;

  const Dish({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.availability,
    required this.type,
    required this.nextUrl,
    required this.addonCat,
  });

  factory Dish.fromMap(Map<String, dynamic> json) {
    List<Addon> temp = [];
    List<dynamic> addonCat = json['addonCat'] ?? [];
    addonCat.forEach((element) {
      temp.add(Addon.fromMap(element));
    });

    return Dish(
      id: json['dish_id'],
      name: json['dish_name'],
      image: json['dish_image'],
      price: json['dish_price'],
      currency: json['dish_currency'],
      calories: json['dish_calories'],
      description: json['dish_description'],
      availability: json['dish_Availability'],
      type: json['dish_Type'],
      nextUrl: json['nexturl'] ?? '',
      addonCat: temp,
    );
  }

  bool get isVeg {
    if (type == 1) {
      return false;
    }
    return true;
  }

  // "dish_id": "100000001",
  // "dish_name": "Spinach Salad",
  // "dish_price": 7.95,
  // "dish_image": "http://restaurants.unicomerp.net//images/Restaurant/1010000001/Item/Items/100000001.jpg",
  // "dish_currency": "SAR",
  // "dish_calories": 15.0,
  // "dish_description": "Fresh spinach, mushrooms, and hard-boiled egg served with warm bacon vinaigrette",
  // "dish_Availability": true,
  // "dish_Type": 2,
  // "nexturl": "http://snapittapp.snapitt.net/api/menu/30/?org=1010000001&branch_id=1000000001&menuItem=100000001&limit=10&offset=20&lang=en",org=1010000001&branch_id=1000000001&limit=10&offset=20&lang=en",

}
