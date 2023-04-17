import 'package:flutter/material.dart';
import 'package:weather_api/constants.dart';
import 'package:weather_api/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'lib/assets/fee51340f855242830b17667892f9c8b.jpg',
          ),
        ),
      ),
      child: Center(
        child: Text(
          "Let,s check the weather now!",
          style: kTestSyle,
        ),
      ),
    );
  }

  Future<void> gotoHomePage() async {
    await Future.delayed(
      const Duration(seconds: 7),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomePage(),
      ),
    );
  }
}
