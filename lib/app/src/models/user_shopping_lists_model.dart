import 'package:app_precos/app/src/models/shopping_list_model.dart';

class UserShoppingLists {
  final int id;
  final String name;
  final List<ShoppingList> userShoppingList;

  UserShoppingLists({
    required this.id,
    required this.name,
    required this.userShoppingList,
  });

  factory UserShoppingLists.fromJson(Map<String, dynamic> json) {
    var listsJson = json['userShoppingList'] as List<dynamic>? ?? [];
    var lists = listsJson.map((e) => ShoppingList.fromJson(e)).toList();

    return UserShoppingLists(
      id: json['id'],
      name: json['name'],
      userShoppingList: lists,
    );
  }
}
