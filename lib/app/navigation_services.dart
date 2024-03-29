import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(Widget viewToShow) {
    return _navigationKey.currentState!
        .push(MaterialPageRoute(
        builder: (context) => viewToShow));
  }

  Future<dynamic> pushReplacement(Widget viewToShow) {
    return _navigationKey.currentState!
        .pushReplacement(MaterialPageRoute(
        builder: (context) => viewToShow));
  }
  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(String newRoute) {
    return   _navigationKey.currentState!.pushNamedAndRemoveUntil(newRoute,  (Route<dynamic> route) => false);

  }

}
