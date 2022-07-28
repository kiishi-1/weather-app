import 'package:flutter/material.dart';

import '../constants/image_keys.dart';
import '../constants/weather_keys.dart';

class CurrentDayContainer extends StatelessWidget {
  const CurrentDayContainer(
      {Key? key,
      required this.color,
      required this.temp,
      required this.time,
      required this.weatherCondition})
      : super(key: key);
  final Color color;
  final String temp;
  final String time;
  final String weatherCondition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      margin: const EdgeInsets.all(15),
      // height: 95,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 65, maxWidth: 75),
            child: Image.asset(
              weatherCondition == WeatherKeys.rainy
                  ? Images.rainy
                  : weatherCondition == WeatherKeys.cloudy
                      ? Images.cloudy
                      : weatherCondition == WeatherKeys.clear
                          ? Images.clear
                          : Images.stormy,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Center(
            child: Text(
              time,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            temp,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
