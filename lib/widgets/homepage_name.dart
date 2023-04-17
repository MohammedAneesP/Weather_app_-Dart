import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class WeatherNameWidget extends StatelessWidget {
  const WeatherNameWidget({
    Key? key,
    required this.kheight,
  }) : super(key: key);

  final double kheight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kheight * 0.15,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "⛅",
                style: TextStyle(fontSize: 40),
              ),
              sizedWdth,
              Text(
                'Weather Now',
                style: GoogleFonts.quantico(
                    fontSize: 30, fontWeight: FontWeight.bold, color: kblack),
              ),
            ],
          ),
          SizedBox(
            height: kheight * 0.02,
          )
        ],
      ),
    );
  }
}
