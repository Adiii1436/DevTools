// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class Weather {
  final String city;
  List<WeatherModel> weather = [];

  Weather({
    required this.city,
  });

  Future<void> getWeather() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=e41dde77d810d45e8147c26c195a85b6&units=metric';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['message'] != "city not found") {
      WeatherModel weatherModel = WeatherModel(
          cityName: jsonData['name'],
          temp: jsonData['main']['temp'],
          wind: jsonData['wind']['speed'],
          pressure: jsonData['main']['pressure'],
          humidity: jsonData['main']['humidity'],
          desc: jsonData['weather'][0]['main'],
          icon: jsonData['weather'][0]['icon']);

      weather.add(weatherModel);
    }
  }
}
