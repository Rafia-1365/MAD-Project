import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getFact() async {
  final apiUrl = 'https://uselessfacts.jsph.pl/random.json?language=en';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData['text'];
  } else {
    throw Exception('Failed to load fact');
  }
}
