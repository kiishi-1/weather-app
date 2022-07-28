import 'package:flutter/material.dart';
import 'package:flutter_weather4/constants/image_keys.dart';
import 'package:flutter_weather4/constants/weather_keys.dart';

class DailyForecastContainer extends StatelessWidget {
  const DailyForecastContainer(
      {Key? key, required this.temp, required this.descipt, required this.days, required this.weatherCondition})
      : super(key: key);
  final String temp;
  final String descipt;
  final String days;
  final String weatherCondition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.all(12),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withOpacity(0.2)),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                temp,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                /* height: 45,
                width: 65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sunny.png'), //fit: BoxFit.cover
                  ),
                ),*/
                constraints: const BoxConstraints(maxHeight: 45, maxWidth: 65),
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
                height: 8,
              ),
              Text(
                descipt,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
