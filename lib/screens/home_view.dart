import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather4/screens/daily_forecast_view.dart';
import 'package:flutter_weather4/screens/search_view.dart';
import 'package:flutter_weather4/services/weather_services.dart';
import 'package:flutter_weather4/widgets/current_day_container.dart';
import 'package:flutter_weather4/widgets/weather_images_container.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, this.val}) : super(key: key);
  final String? val;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var selectedIndex = 0;
  bool isLoading = false;
  //isLoading makes sure the app doesn't build until it gets the data from our services
  WeatherServices weatherServices = WeatherServices();
  Map<String, dynamic> currentData = {};
  //this Map was created hold the data gotten from our services i.e data which is of datatype map<string, dynamic>
  //data is holding the response.body which is data(info) from the API
  List<Map<String, dynamic>> currentData2 = [];
  List<Map<String, dynamic>> currentData3 = [];

  @override
  void initState() {
    //weatherServices.getCurrentWeather();
    //weatherServices.getCurrentWeather2();
    //weatherServices.getCurrentWeather3();
    Future.delayed(Duration(seconds: 2), () => getCurrentData(widget.val));
    //we use widget.val and not q cus we're navigating for searchview to homeview
    //widget.val is the parameter holding value, which is the name of the location we searching for
    //when we're running or opening the app for the first time it'll use "lagos" from q:qq ?? "lagos"
    //q:qq ?? "lagos" means when q is null or empty make lagos the default
    //so i assume the value we put in widget.val will be sent to qq which will be sent to q which will be sent to the Url
    Future.delayed(Duration(seconds: 4), () => getCurrentData2(widget.val));
    Future.delayed(Duration(seconds: 8), () => getCurrentData3(widget.val));
    //future.delayed was used so that the code has enough time to call and return the function

    //getCurrentData();
    //getCurrentData2();
    //getCurrentData3();
    super.initState();
  }

  getCurrentData(qq) async {
    setState(() {
      isLoading = true;
    });
    currentData = await weatherServices.getCurrentWeather(q: qq ?? "lagos");
//q is a variable created so we can pass the name of the location we want to the Url, since we don't to hard code a location to the Url
//q:qq ?? "lagos" means when q is null or empty make lagos the default
    setState(() {
      isLoading = false;
    });
  }

  //this is to get the data from our services for the map currentData to hold

  getCurrentData2(qq) async {
    setState(() {
      isLoading = true;
    });
    currentData2 = await weatherServices.getCurrentWeather2(q: qq ?? "lagos");

    setState(() {
      isLoading = false;
    });
  }

  getCurrentData3(qq) async {
    setState(() {
      isLoading = true;
    });
    currentData3 = await weatherServices.getCurrentWeather3(q: qq ?? "lagos");
    print('object');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: currentData.isEmpty || currentData2.isEmpty || currentData3.isEmpty
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  const [
                    DefaultTextStyle(
                      child: Text(
                        'Fetching Weather Forecast'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          //meaning when any of these variables are empty i.e haven't gotten any data from our services it will keep loading
          //this is to replace isLoading cus isLoading will setState to true and then false before data is gotten from services.
          //i assume cus await is not working as it is supposed to or the code builds faster than data can be gotten from our services
          //hence the condition above
          : Scaffold(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        color: Colors.transparent,
                        height: 65,
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd, MMMM yyyy - KK:mm:ss a')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  currentData["dt"] * 1000)),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(currentData["name"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ]),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                SearchView(
                                                 currentData: currentData,
                                            currentData2: currentData2,
                                            currentData3: currentData3, 
                                                ))));
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                              const SizedBox(
                                width: 7,
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      WeatherImageContainer(
                          weatherCondition: currentData["weather"][0]["main"]),
                      Center(
                        child: Column(children: [
                          Text(
                            currentData["weather"][0]["description"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${(currentData["main"]["temp"] - 273).truncate()}°C",
                            style: const TextStyle(
                                fontSize: 55, color: Colors.white),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                8,
                                (index) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: CurrentDayContainer(
                                          weatherCondition: currentData3[index]
                                                  ["weather"][0]["main"]
                                              .toString(),
                                          time: DateFormat('KK:mm a').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      currentData3[index]
                                                              ["dt"] *
                                                          1000)),
                                          //we use index in d list.generate cus
                                          temp:
                                              "${(currentData3[index]["main"]["temp"] - 273).truncate()}°C",
                                          color: selectedIndex == index
                                              ? Colors.black.withOpacity(0.48)
                                              : Colors.black.withOpacity(0.2)));
                                },
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DailyForecastView(
                                            currentData: currentData,
                                            currentData2: currentData2,
                                            currentData3: currentData3,
                                          )));
                              //print(currentData2);
                            },
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(17, 2, 0, 2),
                                margin: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                                height: 25,
                                width: 195,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Move to Daily Forecast',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 6),
                                      Icon(Icons.arrow_forward_ios,
                                          size: 12, color: Colors.white),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
