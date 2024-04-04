import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_condition.dart';
import 'package:weather_app/models/weather_temperature.dart';

class WeatherAPI {
  static Future<WeatherTemperature?> fetchFromRapidAPI(
      String city, BuildContext context) async {
    String apiKey = 'Enter Your API KEY';
    String endpoints = 'https://open-weather13.p.rapidapi.com/city/${city}/EN';

    Uri url = Uri.parse(endpoints);

    try {
      final response = await http.get(url, headers: {
        'x-rapidapi-host': 'open-weather13.p.rapidapi.com',
        'x-rapidapi-key': apiKey,
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return WeatherTemperature(
            humidity: json['main']['humidity'],
            maxTemperature: json['main']['temp_max'],
            minTemprature: json['main']['temp_min'],
            pressure: json['main']['pressure'],
            temperature: json['main']['temp'],
            windSpeed: json['wind']['speed'],
            city: json['name'],
            weatherDescription: WeatherDescription(
                cloudDescription: json['weather'][0]['description']));
      } else if (response.statusCode == 429) {
        return showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('API Request Limit Reached'),
                content: const Text(
                    'Your host has reached the api request limit which are 50 per month. Try next month.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              );
            });
      }
      // ignore: empty_catches
    } catch (e) {}

    return null;
  }
}
