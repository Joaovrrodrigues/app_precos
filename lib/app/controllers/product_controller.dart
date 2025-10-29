import 'package:flutter/material.dart';
import 'package:app_precos/app/repositories/product_repositorie.dart';
import 'package:app_precos/app/src/models/shopping_item_model.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository _repository;

  ProductController(this._repository);

  List<ShoppingItem> products = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> findAllProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _repository.getAllProducts();
      products = result;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
