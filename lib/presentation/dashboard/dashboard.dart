import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smartpay/app/di.dart';
import 'package:smartpay/app/sizes.dart';
import 'package:smartpay/presentation/dashboard/dashboard_viewmodel.dart';
import 'package:smartpay/presentation/resources/assets_manager.dart';
import 'package:smartpay/presentation/resources/color_manager.dart';
import 'package:smartpay/presentation/resources/routes_manager.dart';
import 'package:smartpay/presentation/resources/styles_manager.dart';
import 'package:smartpay/presentation/resources/values_manager.dart';

import '../../app/navigation_services.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../reuseables/WidgetUtils.dart'; 

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  final NavigationService _navigationService = instance<NavigationService>();

  final DashboardViewModel _viewModel = instance<DashboardViewModel>();

  final List<String> _quotes = [
    "Very little is needed to make a happy life. - Marcus Aurelius",
    "Life is available only in the present moment. - Thich Nhat Hanh",
    "Because you are alive, everything is possible. - Thich Nhat Hanh",
    "Life is available only in the present moment. - Thich Nhat Hanh",
    "When there is no desire, all things are at peace. - Laozi",
    "Order your soul. Reduce your wants. - Augustine",
    "An unexamined life is not worth living. - Socrates",
    "The whole future lies in uncertainty: live immediately. - Seneca",
    "I begin to speak only when I am certain what I will say is not better left unsaid. - Cato the Younger",
    "Simplicity is an acquired taste. - Katharine Gerould",
    "Waste no more time arguing what a good man should be, be one. - Marcus Aurelius"
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

 void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _quotes.length;
      });
    });
  }

// I tried to call the dashbaord API with both DIO and HTTP but I keep getting StatusCode 500

  // _bind() async {
  //   _viewModel.start();
  //   _viewModel.getMessage();
  // }

  //  @override
  // void initState() {
  //   _bind();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(ImageAssets.splashLogo),
            SizedBox(height: resHeight(AppSize.s10, sHeight),),
            SizedBox(
              width: 300.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'OpenSans',
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      _quotes[_currentIndex],
                      textStyle: getMediumStyle(color: ColorManager.textColor),
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 40,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s130, sHeight),),
              Padding(
              padding: EdgeInsets.only(
                  left: resWidth(AppSize.s24, sWidth),
                  right: resWidth(AppSize.s24, sWidth)),
              child: SizedBox(
                width: resWidth(AppSize.s241, sWidth),
                height: AppSize.s50,
                child: ElevatedButton(
                    onPressed: (){
                      _navigationService.navigateReplacementTo(Routes.loginRoute);
                    },
                        
                    child: Text(
                      AppStrings.logout,
                      style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s16),
                    )),
              )),
            
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}