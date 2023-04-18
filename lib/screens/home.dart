import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/apiKey.dart';
import 'package:weather_api/constants.dart';
import 'dart:convert';
import 'package:weather_api/weather_models.dart';
import 'package:weather_api/widgets/homepage_name.dart';

import '../widgets/divider_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

WeatherApi? weatherApiJson;
bool isLoaded = false;
String errorMessage = '';

TextEditingController stateController = TextEditingController();
TextEditingController countryController = TextEditingController();

class _HomePageState extends State<HomePage> {
  String city = 'Kochi';
  String country = 'India';
  Future<WeatherApi?> getWetherRespo(city, country) async {
    final uriParse = Uri.https('weatherapi-com.p.rapidapi.com', '/current.json',
        {"q": "$city,$country"});
    final weathrREspo = await http.get(uriParse, headers: {
      "X-RapidAPI-Key": "$keyApi",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
      "useQueryString": 'true'
    });
    if (weathrREspo.statusCode == HttpStatus.ok) {
      setState(() {
        isLoaded = true;
      });
      final wethrDecode = jsonDecode(weathrREspo.body);
      log(wethrDecode.toString());
      weatherApiJson = WeatherApi.fromJson(wethrDecode);
      return weatherApiJson;
    } else {
      errorMessage = "${weathrREspo.statusCode}:${weathrREspo.body}";
      WeatherApi? o;
      return o;
    }
  }

  @override
  void initState() {
    super.initState();
    getWetherRespo(city, country);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = [
      weatherApiJson?.current.tempF,
      weatherApiJson?.current.windKph,
      weatherApiJson?.current.humidity,
      weatherApiJson?.current.cloud,
      weatherApiJson?.current.windDir,
      weatherApiJson?.current.uv,
    ];
    List<String> cardTitle = [
      'Farenheat',
      'WindSpeed',
      'HUmidity',
      'Cloud',
      'Direction',
      'UV Rays',
    ];
    final kwidth = MediaQuery.of(context).size.width;
    final kheight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                WeatherNameWidget(kheight: kheight),
                sizedHght20,
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('lib/assets/lightning (1).jpg'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            boxShadow2,
                          ],
                          // color: Colors.redAccent,
                          borderRadius: borderRadius2,
                        ),
                        height: kheight * .25,
                        width: kwidth * 0.46,
                        child: Column(
                          children: [
                            sizedHght20,
                            textFormMethod(kheight, 'City/State...',
                                stateController, kwidth * 14),
                            sizedHght10,
                            textFormMethod(kheight, 'Country Name...',
                                countryController, kwidth * 14),
                            sizedHght10,
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.lightBlue.withOpacity(0.4))),
                              onPressed: () {
                                setState(
                                  () {
                                    city = stateController.text;
                                    country = countryController.text;
                                    getWetherRespo(city, country);
                                    errorMessage = '';
                                  },
                                );
                              },
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: kheight * .25,
                        width: kwidth * 0.46,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [boxShadow2],
                            borderRadius: borderRadius2),
                        child: isLoaded == false
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : errorMessage.isNotEmpty
                                ? Center(
                                    child: Text(errorMessage),
                                  )
                                : weatherApiJson == null
                                    ? const Center(
                                        child: Text("No data"),
                                      )
                                    : Container(
                                        height: kheight * .25,
                                        decoration: BoxDecoration(
                                          borderRadius: borderRadius2,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                weatherApiJson!.current.isDay ==
                                                        1
                                                    ? imgString[1]
                                                    : imgString[4],
                                              ),
                                              alignment: Alignment.topRight,
                                              fit: BoxFit.cover),
                                        ),
                                        child: Column(
                                          children: [
                                            sizedHght20,
                                            sizedWdth,
                                            Stack(
                                              children: [
                                                Card(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  child: Text(
                                                    weatherApiJson!
                                                        .location.localtime
                                                        .split(" ")[1],
                                                    style: weatherApiJson!
                                                                .current
                                                                .isDay ==
                                                            1
                                                        ? textStyleMethod(
                                                            22, kblack)
                                                        : textStyleMethod(
                                                            22, kblack),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Card(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              child: Text(
                                                weatherApiJson!.location.name,
                                                style: weatherApiJson!
                                                            .current.isDay ==
                                                        1
                                                    ? textStyleMethod(
                                                        24, kblack)
                                                    : textStyleMethod(
                                                        22, kblack),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                      ),
                    ],
                  ),
                ),
                sizedHght20,
                Container(
                  height: kheight * .47,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius2,
                    boxShadow: [boxShadow2],
                    image: weatherApiJson?.current.isDay == 1
                        ? const DecorationImage(
                            image: AssetImage('lib/assets/cloudy.jpg'),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                                'lib/assets/—Pngtree—night_5054269.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kheight * 0.33,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedHght10,
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'lib/assets/pngwing.com.png',
                                      ),
                                    ),
                                  ),
                                ),
                                const DividerContainer(),
                                sizedWdth20,
                                Text(
                                  '${weatherApiJson?.current.tempC}°C',
                                  style: GoogleFonts.quantico(
                                    color: weatherApiJson?.current.isDay == 1
                                        ? kblack
                                        : kWhite,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            sizedHght10,
                            Row(
                              children: [
                                sizedWdth20,
                                Text(
                                  '${weatherApiJson?.location.name}',
                                  style: GoogleFonts.quantico(
                                      color: weatherApiJson?.current.isDay == 1
                                          ? kblack
                                          : kWhite,
                                      fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                ),
                                sizedWdth,
                                const DividerContainer(),
                                sizedWdth,
                                Text(
                                  '${weatherApiJson?.location.region}',
                                  style: GoogleFonts.quantico(
                                      color: weatherApiJson?.current.isDay == 1
                                          ? kblack
                                          : kWhite,
                                      fontSize: 15,),
                                      overflow: TextOverflow.ellipsis,
                                ),
                                sizedWdth,
                                const DividerContainer(),
                                sizedWdth,
                              ],
                            ),
                            Row(
                              children: [
                                sizedWdth20,
                                Text(
                                  "Feels Like",
                                  style: GoogleFonts.quantico(
                                      color: weatherApiJson?.current.isDay == 1
                                          ? kblack
                                          : kWhite,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sizedWdth20,
                                Text(
                                  '${weatherApiJson?.current.feelslikeC.toString()}°C',
                                  style: GoogleFonts.quantico(
                                      color: weatherApiJson?.current.isDay == 1
                                          ? kblack
                                          : kWhite,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      sizedHght10,
                      Container(
                        height: 97,
                        decoration: const BoxDecoration(
                          borderRadius: borderRadius2,
                          //color: Colors.amber,
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 100,
                              width: 100,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${cardImoji[index]}',
                                        style: textStyleMethod(30, kblack),
                                      ),
                                      Text(
                                        '${cardData[index]}',
                                        style: textStyleMethod(20, kblack),
                                      ),
                                      Text(
                                        cardTitle[index],
                                        style: textStyleMethod(13, kblack),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return sizedWdth;
                          },
                          itemCount: cardData.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<dynamic> cardImoji = [
    '🔥',
    '🍃',
    '🌡️',
    '☁️',
    '🌬️',
    '☀️',
  ];

  TextStyle textStyleMethod(double sizeOfFont, Color kWhitei) {
    return TextStyle(
      fontSize: sizeOfFont,
      fontWeight: FontWeight.bold,
      color: kWhitei,
    );
  }

  SizedBox textFormMethod(double kheight, String hint,
      TextEditingController anController, double kwidth) {
    return SizedBox(
      height: kheight * 0.05,
      width: kwidth * 0.03,
      child: TextFormField(
        textAlignVertical: const TextAlignVertical(y: 0.95),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          hintText: hint,
          fillColor: Colors.white.withOpacity(.6),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(style: BorderStyle.solid),
          ),
        ),
        controller: anController,
      ),
    );
  }
}
