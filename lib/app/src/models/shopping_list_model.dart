import 'package:app_precos/app/src/models/shopping_item_model.dart';

class ShoppingList {
  final String id;
  final String name;
  final String? description;
  final double totalPrice;
  final double discountTotalPrice;
  final List<ShoppingItem> items;

  ShoppingList({
    required this.id,
    required this.name,
    this.description,
    required this.totalPrice,
    required this.discountTotalPrice,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Description": description,
      "TotalPrice": totalPrice,
      "DiscountTotalPrice": discountTotalPrice,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List<dynamic>? ?? [];
    var itemsList = itemsJson.map((e) => ShoppingItem.fromJson(e)).toList();

    return ShoppingList(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      discountTotalPrice:
          (json['discountTotalPrice'] as num?)?.toDouble() ?? 0.0,
      items: itemsList,
    );
  }
}
