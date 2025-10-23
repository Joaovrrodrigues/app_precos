import 'package:app_precos/app/repositories/user_list_repositorie.dart';
import 'package:flutter/material.dart';
import 'package:app_precos/app/src/models/shopping_list_model.dart';


class ListController extends ChangeNotifier {
  final UserListRepository _repository;

  ListController(this._repository);

  List<ShoppingList> lists = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchLists({int userId = 3}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _repository.getUserLists(userId);
      lists = result.userShoppingList;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
