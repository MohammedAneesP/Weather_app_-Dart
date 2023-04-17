import 'package:flutter/material.dart';
import 'package:weather_api/constants.dart';

class DividerContainer extends StatelessWidget {
  const DividerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: kWhite.withOpacity(0.5),
    );
  }
}
