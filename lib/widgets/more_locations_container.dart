import 'package:flutter/material.dart';
import 'package:flutter_weather4/constants/image_keys.dart';
import 'package:flutter_weather4/constants/weather_keys.dart';

class MoreLocationsContainer extends StatelessWidget {
  const MoreLocationsContainer(
      {Key? key,
      required this.color2,
      required this.location,
      required this.temp,
      required this.descript,
      required this.weatherCondition
      })
      : super(key: key);
  final Color color2;
  final String location;
  final String temp;
  final String descript;
  final String weatherCondition;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(12),
      height: 90,
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: color2),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    temp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    descript,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: Container(
              /* height: 45,
              width: 65,
              decoration: const BoxDecoration(
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
          ),
        ],
      ),
    );
  }
}
