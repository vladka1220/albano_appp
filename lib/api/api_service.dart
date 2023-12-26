import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<String> getData() async {
    var url = Uri.parse('$baseUrl/data');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Ошибка при получении данных');
    }
  }

  // Другие методы для POST, PUT, DELETE и т.д. могут быть добавлены здесь
}
