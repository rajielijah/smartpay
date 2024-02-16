// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WidgetUtils{
  static double screenWidth = 0;
  static double screenHeight = 0;

  init(BuildContext context){
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

  }

}