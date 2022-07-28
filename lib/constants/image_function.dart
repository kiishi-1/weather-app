import 'package:flutter/material.dart';
class ImageFunction{

  Future<Image> loadImg(BuildContext context, String path) async {
    var image = Image.asset(path);
    await precacheImage(image.image, context);
    return image;
  }
}