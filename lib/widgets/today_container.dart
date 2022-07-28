import 'package:flutter/material.dart';
import 'package:flutter_weather4/constants/image_keys.dart';
import 'package:flutter_weather4/constants/weather_keys.dart';

class TodayContainer extends StatelessWidget {
  const TodayContainer(
      {Key? key,
      required this.color3,
      required this.location,
      required this.temp,
      required this.descript,
      required this.time,
      required this.weatherCondition
      })
      : super(key: key);
  final Color color3;
  final String location;
  final String temp;
  final String descript;
  final String time;
  final String weatherCondition;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(12),
      height: 135,
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color3,
      ),
      child: Column(
        children: [
          Text(
            location,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            /*height: 45,
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
            time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                temp,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                descript,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
