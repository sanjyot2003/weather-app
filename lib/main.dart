import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  getNetworkStatus();
  runApp(const MyApp());
}

void getNetworkStatus() async {
  final status = await Connectivity().checkConnectivity();
  if (status == ConnectionState.done) {
    print("Connected");
  } else {
    print("Not Connected");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Mobile Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: const Home(),
    );
  }
}
