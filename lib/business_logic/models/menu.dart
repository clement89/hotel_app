import 'package:firebase_demo/business_logic/models/dish.dart';

class Menu {
  final String id;
  final String name;
  final String image;
  final String nextUrl;
  final List<Dish> dishList;

  const Menu({
    required this.id,
    required this.name,
    required this.image,
    required this.nextUrl,
    required this.dishList,
  });

  factory Menu.fromMap(Map<String, dynamic> json) {
    List<dynamic> dishes = json['category_dishes'];
    List<Dish> temp = [];
    dishes.forEach((element) {
      temp.add(Dish.fromMap(element));
    });

    return Menu(
      id: json['menu_category_id'],
      name: json['menu_category'],
      image: json['menu_category_image'],
      nextUrl: json['nexturl'],
      dishList: temp,
    );
  }

  // "menu_category": "Salads and Soup",
  // "menu_category_id": "11",
  // "menu_category_image": "http://restaurants.unicomerp.net/images/Restaurant/Item/ItemGroup_11.jpg",
  // "nexturl": "http://snapittapp.snapitt.net/api/menu/20/?org=1010000001&branch_id=1000000001&menuCat=11&limit=10&offset=20&lang=en",

}
