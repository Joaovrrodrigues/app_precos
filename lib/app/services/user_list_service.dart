import 'dart:convert';
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
}
