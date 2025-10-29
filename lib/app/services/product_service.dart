import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl = 'https://api-preco-certo.onrender.com/api/v1';

 Future<List<dynamic>> getAllProducts() async {
  final url = Uri.parse('$baseUrl/product');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
  } else {
    throw Exception('Erro ao buscar produtos');
  }
}

}
