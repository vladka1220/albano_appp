import 'package:http/http.dart' as http;

Future<void> fetchServerData() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080'));

  if (response.statusCode == 200) {
    print('Server response: ${response.body}');
  } else {
    print('Failed to connect to server');
  }
}
