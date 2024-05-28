import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final String apiKey;
  final String city;

  Weather({this.apiKey = 'ee3b7043dd5d9356c6c700d2685abc91', this.city = 'Faisalabad'});

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<double> getTemperature() async {
    try {
      final weatherData = await fetchWeatherData();
      final temp = weatherData['main']['temp'];
      return temp.toDouble();
    } catch (e) {
      throw Exception('Failed to get temperature: $e');
    }
  }

  Future<String> getDescription() async {
    try {
      final weatherData = await fetchWeatherData();
      final description = weatherData['weather'][0]['description'];
      return description;
    } catch (e) {
      throw Exception('Failed to get weather description: $e');
    }
  }
}
