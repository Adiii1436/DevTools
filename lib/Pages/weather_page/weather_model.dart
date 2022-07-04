// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  String cityName;
  String desc;
  double temp;
  double wind;
  int humidity;
  double feelsLike;
  int pressure;
  String icon;

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    required this.pressure,
    required this.desc,
    required this.icon,
  });
}
