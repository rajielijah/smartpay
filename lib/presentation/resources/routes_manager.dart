import 'package:flutter/material.dart';
import 'package:smartpay/presentation/resources/strings_manager.dart';

import '../../app/di.dart';
import '../login/login.dart';
import '../reuseables/WidgetUtils.dart';
import '../splash/splash.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String landingPageRoute = "/landingPage";
  static const String loginRoute = "/login";
  static const String otpRoute = "/otp";
  
}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
       case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (context) {
          WidgetUtils().init(context);
          return const LoginView();
        }
        );
      default:
        return unDefinedRoute();
    }
    
  }

   static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}