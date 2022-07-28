import 'package:flutter/material.dart';
import 'package:flutter_weather4/constants/image_function.dart';
import 'package:flutter_weather4/constants/image_keys.dart';
import 'package:flutter_weather4/screens/home_view.dart';
//import 'package:flutter_weather4/screens/home.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
final ImageFunction imageFunction = ImageFunction();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future.wait([
      // preloading asset images
      imageFunction.loadImg(context, Images.clear),
      imageFunction.loadImg(context, Images.cloudy),
      imageFunction.loadImg(context, Images.rainy),
      imageFunction.loadImg(context, Images.stormy),
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomeView(),
    );
  }
}

