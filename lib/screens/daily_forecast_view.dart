import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather4/widgets/daily_forecast_container.dart';
import 'package:flutter_weather4/widgets/today_container.dart';
import 'package:flutter_weather4/screens/home_view.dart';
import 'package:intl/intl.dart';

class DailyForecastView extends StatefulWidget {
  DailyForecastView({
    Key? key,
    required this.currentData,
    required this.currentData2,
    required this.currentData3
  }) : super(key: key);
  Map<String, dynamic> currentData = {};
  List<Map<String, dynamic>> currentData2 = [];
  List<Map<String, dynamic>> currentData3 = [];
  @override
  State<DailyForecastView> createState() => _DailyForecastViewState();
}

class _DailyForecastViewState extends State<DailyForecastView> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyanAccent,
                Colors.blueGrey,
                Colors.black,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                         Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            8,
                            (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: TodayContainer(
                                  weatherCondition: widget.currentData3[index]["weather"][0]["main"].toString(),
                                  location: widget.currentData["name"],
                                  temp: "${(widget.currentData3[index]["main"]["temp"] - 273).truncate()}°C",
                                  descript: widget.currentData3[index]["weather"][0]["description"],
                                  time: DateFormat('KK:mm a').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      widget.currentData3
                                                      
                                                      [index]
                                                              ["dt"] *
                                                          1000)),
                                    color3: selectedIndex == index
                                        ? Colors.black.withOpacity(0.48)
                                        : Colors.black.withOpacity(0.2)))),
                      ],
                    )),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    'Daily Forcast',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  child: Column(children: [
                    ...List.generate(widget.currentData2.length, //or 7. you had error cus you gave a length of 8
                    //if you give a length greater than what the  or rather length of the data is you'll get a range error
                     (index) => DailyForecastContainer(
                      weatherCondition: widget.currentData2[index]["weather"][0]["main"],
                      days: //'dddddd'
                      DateFormat('EEEE').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      widget.currentData2[index]
                                                              ["dt"] *
                                                          1000)),
                      temp: //'hhhhhhh'
                      "${(widget.currentData2[index]["temp"]["day"] - 273).truncate()}°C"
                      ,
                      //widget.currentData2[index]["temp"]["day"],
                      descipt: //'t677'
                      widget.currentData2[index]["weather"][0]["description"]
                      ,
                    ))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
