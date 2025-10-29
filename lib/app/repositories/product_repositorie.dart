import 'package:app_precos/app/services/product_service.dart';
import 'package:app_precos/app/src/models/shopping_item_model.dart';

class ProductRepository {
  final ProductService _service;

  ProductRepository(this._service);

  Future<List<ShoppingItem>> getAllProducts() async {
    final data = await _service.getAllProducts();

    return data.map((json) => ShoppingItem.fromJson(json)).toList();
  }
}
