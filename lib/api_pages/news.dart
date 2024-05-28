import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchNews() async {
  final apiKey = 'd701eb3863e34cd2831f6e13c6831733'; // Replace with your actual API key
  final apiUrl = 'https://newsapi.org/v2/everything?q=keyword&apiKey=$apiKey';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    List<String> newsArticles = [];
    for (int i = 0; i < 3; i++) {
      newsArticles.add("Number ${i + 1}, ${jsonData["articles"][i]["title"]}.");
    }
    return newsArticles;
  } else {
    throw Exception('Failed to load news');
  }
}
