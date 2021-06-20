import 'package:firebase_demo/business_logic/models/dish.dart';

class Addon {
  final String id;
  final String category;
  final int selection;
  final String nextUrl;
  final List<Dish> addons;

  const Addon({
    required this.id,
    required this.category,
    required this.selection,
    required this.nextUrl,
    required this.addons,
  });

  factory Addon.fromMap(Map<String, dynamic> json) {
    List<dynamic> dishes = json['addons'];
    List<Dish> temp = [];
    dishes.forEach((element) {
      temp.add(Dish.fromMap(element));
    });

    return Addon(
      id: json['addon_category_id'],
      category: json['addon_category'],
      selection: json['addon_selection'],
      nextUrl: json['nexturl'],
      addons: temp,
    );
  }

  // "addon_category": "Add On",
  // "addon_category_id": "101",
  // "addon_selection": 1,
  // "nexturl": "http://snapittapp.snapitt.net/api/menu/40/?org=1010000001&branch_id=1000000001&menuItem=100000008&menuAddonCat=101&menuAddonselc=1&limit=10&offset=20&lang=en",

}
