import 'package:app_precos/app/services/user_list_service.dart';
import 'package:app_precos/app/src/models/shopping_list_model.dart';
import 'package:app_precos/app/src/models/user_shopping_lists_model.dart';

class UserListRepository {
  final UserListService _service;

  UserListRepository(this._service);

  Future<UserShoppingLists> getUserLists(int userId) async {
    final data = await _service.getUserLists(userId);
    return UserShoppingLists.fromJson(data);
  }

  Future<String?> deleteList(String listId, int userId) async {
    final deletedId = await _service.deleteList(listId, userId);
    return deletedId;
  }

  Future<bool> postNewList(int userId, ShoppingList newList) async {
    return await _service.postNewList(userId, newList);
  }
}
