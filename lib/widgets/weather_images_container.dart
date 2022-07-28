import 'package:flutter/material.dart';
import 'package:flutter_weather4/constants/image_keys.dart';
import 'package:flutter_weather4/constants/weather_keys.dart';

class WeatherImageContainer extends StatelessWidget {
  const WeatherImageContainer({Key? key, required this.weatherCondition}) : super(key: key);
  final String weatherCondition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
     width: double.infinity,
     constraints: const BoxConstraints(maxHeight: 165),
      child: Image.asset(
        weatherCondition == WeatherKeys.rainy
        ? Images.rainy
        : weatherCondition == WeatherKeys.cloudy
        ? Images.cloudy
        : weatherCondition == WeatherKeys.clear
        ? Images.clear
        : Images.stormy
      ),
    );
  }
}
