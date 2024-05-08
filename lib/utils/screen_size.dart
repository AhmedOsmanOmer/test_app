import 'package:flutter/material.dart';

class ScreenSize {
  final BuildContext context;

  ScreenSize({required this.context});

  double getHeight() {
    return MediaQuery.of(context).size.height;
  }
  double getWidth(){
    return MediaQuery.of(context).size.width;
  }

   double fontSize(double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return baseSize * 0.8; 
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      return baseSize * 1.0; 
    } else {
      return baseSize * 1.2; 
    }
  }

  
}
