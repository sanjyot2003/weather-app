import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var searchedCity = '';
  var desc = '';
  var temp = 0.0;
  var minTemp = 0.0;
  var maxTemp = 0.0;
  var humid = 0;
  var windSpeed = 0;
  var pressure = 0;

  Future<void> fetchData(String city) async {
    final report = await WeatherAPI.fetchFromRapidAPI(city, context);
    if (report == null) {
      return;
    }
    setState(() {
      searchedCity = report.city;
      desc = report.weatherDescription.cloudDescription;
      temp = ((report.temperature - 32) * (5.0 / 9.0));
      minTemp = ((report.minTemprature - 32) * (5.0 / 9.0));
      maxTemp = ((report.maxTemperature - 32) * (5.0 / 9.0));
      humid = report.humidity;
      windSpeed = double.parse(report.windSpeed.toString()).round();
      pressure = report.pressure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'W E A T H E R   A P P',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(Icons.cloud),
        backgroundColor: Colors.grey.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: MediaQuery.of(context).size.width * 0.70 * 0.17,
                        child: SearchBar(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.grey.shade800)),
                          hintText: 'City',
                          hintStyle: MaterialStateProperty.all(
                              const TextStyle(color: Colors.grey)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 15)),
                          elevation: MaterialStateProperty.all(1),
                          leading: const Icon(Icons.place),
                          onSubmitted: (value) {
                            fetchData(value);
                            searchedCity = value.toUpperCase();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.038,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                        ),
                        Column(
                          children: [
                            Text(
                              searchedCity.isEmpty
                                  ? 'Search City'
                                  : searchedCity,
                              style: TextStyle(
                                fontSize: searchedCity.length > 15
                                    ? MediaQuery.of(context).size.width * 0.050
                                    : MediaQuery.of(context).size.width * 0.064,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Text(
                              desc.isEmpty ? 'City Description' : desc,
                              style: TextStyle(color: Colors.grey.shade700),
                            )
                          ],
                        ),
                        Lottie.asset(
                          'assets/animations/hello.json',
                          width: MediaQuery.of(context).size.width * 0.36,
                          height: MediaQuery.of(context).size.width * 0.36,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                height: 15,
                thickness: 0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(35)),
                  child: Lottie.asset(
                    "assets/animations/sun.json",
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Temperature',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.040),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      temp == 0.0
                          ? '-'
                          : "${temp.toStringAsFixed(2).toString()}°C",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.060),
                    )
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Divider(
                thickness: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  weatherWidget(
                      'Minimum',
                      'minimum',
                      minTemp == 0.0
                          ? '-'
                          : "${minTemp.toStringAsFixed(2).toString()}°C",
                      context),
                  weatherWidget(
                      'Maximum',
                      'maximum',
                      maxTemp == 0.0
                          ? '-'
                          : "${maxTemp.toStringAsFixed(2).toString()}°C",
                      context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weatherWidget(
                      'Humidity',
                      'humidity',
                      humid == 0.0
                          ? '-'
                          : "${humid.toStringAsFixed(2).toString()}%",
                      context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  weatherWidget(
                      'Wind Speed',
                      'wind_speed',
                      minTemp == 0.0
                          ? '-'
                          : "${windSpeed.toStringAsFixed(2).toString()} km/h",
                      context),
                  weatherWidget(
                      'Pressure',
                      'pressure',
                      maxTemp == 0.0
                          ? '-'
                          : "${pressure.toStringAsFixed(2).toString()} Mtr.Ton",
                      context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget weatherWidget(
    String title, String lottieString, var value, BuildContext context) {
  final widgetWidth = MediaQuery.of(context).size.width * 0.4;
  return SizedBox(
    width: widgetWidth,
    height: widgetWidth * 1.2,
    child: Card(
      elevation: 0.39,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: widgetWidth * 0.10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.037),
            ),
            Lottie.asset("assets/animations/$lottieString.json",
                height: widgetWidth * 0.55, width: widgetWidth * 0.55),
            Text(
              value,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.040),
            ),
          ],
        ),
      ),
    ),
  );
}
