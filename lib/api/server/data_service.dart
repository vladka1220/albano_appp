import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../customs/dados_da bobine/BobinaDetailsPage.dart';

class DataService {
  final String serverUrl;

  DataService(this.serverUrl);

  Future<bool> saveBobinaData(BobinaData data) async {
    var url = Uri.parse('$serverUrl/saveBobinaData');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      // Обработка успешного сохранения
      return true;
    } else {
      // Обработка ошибки
      return false;
    }
  }

  // Методы для загрузки и обработки других запросов...
}
