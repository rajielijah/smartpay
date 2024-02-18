import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }

}

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPasswordValid(String password) {
  return RegExp(
          "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@!%*?&])[A-Za-z\\d@!%*?&]{6,}")
      .hasMatch(password);
}


Future<dynamic> updateConnectionStatus(ConnectivityResult result) async {
  if (result == ConnectivityResult.mobile) {
    return Fluttertoast.showToast(
        msg: "Connected to Mobile Network",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } else if (result == ConnectivityResult.wifi) {
    return Fluttertoast.showToast(
        msg: "Connected to WIFI Network",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } else if (result == ConnectivityResult.none) {
    return Fluttertoast.showToast(
        msg: "No Internet connection found",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  return true;
}

