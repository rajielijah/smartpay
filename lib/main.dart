import 'package:flutter/material.dart';
import 'package:smartpay/app/di.dart';
import 'package:smartpay/presentation/resources/routes_manager.dart';
import 'package:smartpay/presentation/resources/theme_manager.dart';

import 'app/navigation_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
      navigatorKey: instance<NavigationService>().navigationKey,
      );
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
  
  }
}
