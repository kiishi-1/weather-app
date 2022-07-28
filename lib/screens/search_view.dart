import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_weather4/screens/home_view.dart';
import 'package:flutter_weather4/widgets/more_locations_container.dart';
import 'package:flutter_weather4/widgets/recent_search_container.dart';
import 'package:flutter_weather4/services/weather_services.dart';
import '../widgets/more_locations_container.dart';

class SearchView extends StatefulWidget {
  SearchView(
      {Key? key,
      this.val,
      required this.currentData,
      required this.currentData2,
      required this.currentData3})
      : super(key: key);
  final String? val;
  Map<String, dynamic> currentData = {};
  List<Map<String, dynamic>> currentData2 = [];
  List<Map<String, dynamic>> currentData3 = [];
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  WeatherServices weatherServices = WeatherServices();
  List<String> worldList = [
    "Ireland",
    //"Alaska",
    "Rome",
    "Athens",
    "Iceland",
  ];
  Map<String, dynamic> currentData = {};
  late List<Map<String, dynamic>> worldDataList = [];
  //we are putting whatever we get in currntData in worldDataList
  final TextEditingController controller1 = TextEditingController();
  var selectedIndex = 0;
  var selectedIndex2 = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 22), () => worldListFn());
    controller1.addListener(() {
      setState(() {});
    });
  }

  worldListFn() async {
    setState(() {
      isLoading = true;
    });
    for (var i in worldList) {
      currentData = await weatherServices.getCurrentWeather(q: i);
      worldDataList.add(currentData);
      print(worldDataList);
      print('this is worldDataList');
      setState(() {
        worldDataList;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: currentData.isEmpty ||
              worldDataList.isEmpty ||
              worldDataList.length < worldList.length
          ? Center(
              child: CircularProgressIndicator(),
            )
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
                  child: ListView(children: [
                    Container(
                        padding: const EdgeInsets.all(18),
                        color: Colors.transparent,
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'Search for Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      width: 25,
                      height: 55,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          value = controller1.text;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView(
                                        val: value,
                                      )));
                        },
                        controller: controller1,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: controller1.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => controller1.clear(),
                                  ),
                            hintText: 'Search',
                            hintMaxLines: 1,
                            hintStyle: const TextStyle(
                                fontSize: 20, color: Colors.white38),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(
                                color: Colors.white38,
                                width: 1,
                                //style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ))),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text(
                        'Previously Searched',
                        style: TextStyle(
                          color: Colors.white38,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                1,
                                (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: RecentSearchContainer(
                                        color: selectedIndex == index
                                            ? Colors.black.withOpacity(0.48)
                                            : Colors.black.withOpacity(0.2)))),
                          ],
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 35,
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white38)),
                          child: const Center(
                            child: Text(
                              'more locations',
                              style: TextStyle(
                                  color: Colors.white38,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        ...List.generate(
                            worldDataList.length,
                            (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex2 = index;
                                    //print(selectedIndex2);
                                  });
                                },
                                child: MoreLocationsContainer(
                                    weatherCondition: widget
                                        .currentData["weather"][0]
                                            ["description"]
                                        .toString(),
                                    location:
                                        worldDataList[index]["name"].toString(),
                                    temp:
                                        "${(worldDataList[index]["main"]["temp"] - 273).truncate()}°C -",
                                    descript: worldDataList[index]["weather"][0]
                                        ["description"],
                                    color2: selectedIndex2 == index
                                        ? Colors.black.withOpacity(0.48)
                                        : Colors.black.withOpacity(0.2))))
                      ]),
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
