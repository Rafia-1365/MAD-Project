import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

Future<List<String>> fetchJoke() async {
  try {
    final apiUrl = 'https://official-joke-api.appspot.com/random_joke';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final setup = jsonData["setup"];
      final punchline = jsonData["punchline"];
      final jokeText = "$setup $punchline"; // Combine setup and punchline

      // Speak the joke
      final FlutterTts flutterTts = FlutterTts();
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(jokeText);

      // Return the joke setup and punchline
      return [setup, punchline];
    } else {
      throw Exception('Failed to load joke');
    }
  } catch (e) {
    print("Error fetching and speaking joke: $e");
    throw Exception('Failed to fetch and speak joke');
  }
}
