class ShoppingItem {
  final String id;
  final String name;
  final String? description;
  final int quantity;
  final String unit;
  final String brand;
  final double price;
  final double discountValue;
  final bool isPurchased;

  ShoppingItem({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.unit,
    required this.brand,
    required this.price,
    required this.discountValue,
    required this.isPurchased,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "quantity": quantity,
      "unit": unit,
      "brand": brand,
      "price": price,
      "discountValue": discountValue,
      "isPurchased": isPurchased,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unit: json['unit'],
      brand: json['brand'],
      price: (json['price'] as num).toDouble(),
      discountValue: (json['discountValue'] as num).toDouble(),
      isPurchased: json['isPurchased'],
    );
  }
}
