import 'package:flutter/material.dart';
import 'package:app_precos/app/repositories/user_list_repositorie.dart';
import 'package:app_precos/app/src/models/shopping_list_model.dart';

class ListController extends ChangeNotifier {
  final UserListRepository _repository;

  ListController(this._repository);

  List<ShoppingList> lists = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchLists({int userId = 3}) async {
    _setLoading(true);

    try {
      final result = await _repository.getUserLists(userId);
      lists = result.userShoppingList;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteList(int userId, String listId) async {
    _setLoading(true);

    try {
      final deletedId = await _repository.deleteList(listId, userId);

      if (deletedId != null) {
        lists.removeWhere((list) => list.id == listId);
        notifyListeners();
        await fetchLists(userId: userId);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Erro ao deletar lista: $errorMessage');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addNewList(int userId, ShoppingList newList) async {
    _setLoading(true);

    try {
      final created = await _repository.postNewList(userId, newList);

      if (created) {
        await fetchLists(userId: userId);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      debugPrint('Erro ao criar lista: $errorMessage');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
