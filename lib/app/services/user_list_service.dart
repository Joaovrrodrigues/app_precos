import 'dart:convert';
import 'package:app_precos/app/src/models/shopping_list_model.dart';
import 'package:http/http.dart' as http;

class UserListService {
  static const String baseUrl = 'https://api-preco-certo.onrender.com/api/v1';

  Future<Map<String, dynamic>> getUserLists(int userId) async {
    final url = Uri.parse('$baseUrl/userlist/$userId/lists');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao buscar listas do usuário');
    }
  }

  Future<String?> deleteList(String listId, int userId) async {
    final url = Uri.parse('$baseUrl/userlist/$userId/$listId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? response.body : null;
    } else {
      throw Exception(
        'Erro ao deletar lista: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<bool> postNewList(int userId, ShoppingList newList) async {
    final url = Uri.parse('$baseUrl/userlist/$userId/new');
    final body = json.encode(newList.toJson());

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Erro ao criar nova lista: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao enviar requisição: $e');
    }
  }
}
