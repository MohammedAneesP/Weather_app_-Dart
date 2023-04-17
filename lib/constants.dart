import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const sizedHght10 = SizedBox(height: 10);
const sizedHght20 = SizedBox(height: 20);

final kTestSyle = GoogleFonts.quantico(color: kWhite, fontSize: 20);

const sizedWdth = SizedBox(width: 10);
const sizedWdth20 = SizedBox(width: 20);

var boxShadow2 = BoxShadow(
  color:const Color.fromARGB(255, 99, 94, 94).withOpacity(0.9),
  spreadRadius: 5,
  blurRadius: 15,
  offset: const Offset(0, 10),
);

const borderRadius2 = BorderRadius.only(
    bottomLeft: Radius.zero,
    topRight: Radius.zero,
    bottomRight: Radius.circular(15),
    topLeft: Radius.circular(15));

const kWhite = Colors.white;
const kblack = Colors.black;
final kBlue = Colors.blueAccent[700];

List<String> imgString = [
  'lib/assets/day.png',
  'lib/assets/goodDay.png',
  'lib/assets/hot.png',
  'lib/assets/night rain.jpg',
  'lib/assets/night.png',
  'lib/assets/rainig.png',
  'lib/assets/raining cloud.png',
  'lib/assets/snowy.png',
  'lib/assets/sunset.png',
  'lib/assets/very hot.png',
];
