import 'package:flutter/material.dart';
import 'package:weather_api/screens/home.dart';
import 'package:weather_api/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        //backgroundColor: Colors.cyanAccent,
        // primarySwatch: Colors.blueGrey,
      ),
      home:const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}