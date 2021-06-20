import 'package:firebase_demo/business_logic/models/menu.dart';

class Hotel {
  final String id;
  final String name;
  final String image;
  final String tableId;
  final String tableName;
  final String branchName;
  final String nextUrl;
  final List<Menu> menuList;

  Hotel({
    required this.id,
    required this.name,
    required this.image,
    required this.tableId,
    required this.tableName,
    required this.branchName,
    required this.nextUrl,
    required this.menuList,
  });

  factory Hotel.fromMap(Map<String, dynamic> json) {
    List<dynamic> menuItems = json['table_menu_list'];
    List<Menu> temp = [];
    menuItems.forEach((element) {
      temp.add(Menu.fromMap(element));
    });

    return Hotel(
      id: json['restaurant_id'],
      name: json['restaurant_name'],
      image: json['restaurant_image'],
      tableId: json['table_id'],
      tableName: json['table_name'],
      branchName: json['branch_name'],
      nextUrl: json['nexturl'],
      menuList: temp,
    );
  }

  // "restaurant_id": "1010000001",
  // "restaurant_name": "UNI Resto Cafe",
  // "restaurant_image": "http://restaurants.unicomerp.net/images/Restaurant/1010000001.jpg",
  // "table_id": "1",
  // "table_name": "Riyadh-Table 01",
  // "branch_name": "UNI Resto Cafe-Riyadh",
  // "nexturl": "http://snapittapp.snapitt.net/api/menu/10/?org=1010000001&branch_id=1000000001&limit=10&offset=20&lang=en",

}
