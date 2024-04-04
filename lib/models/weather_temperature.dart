// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:weather_app/models/weather_condition.dart';

class WeatherTemperature {
  var temperature;
  var minTemprature;
  var maxTemperature;
  var pressure;
  var humidity;
  var windSpeed;

  String city;
  WeatherDescription weatherDescription;

  WeatherTemperature(
      {required this.temperature,
      required this.humidity,
      required this.maxTemperature,
      required this.minTemprature,
      required this.pressure,
      required this.windSpeed,
      required this.city,
      required this.weatherDescription});
}
