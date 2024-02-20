import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartpay/presentation/resources/assets_manager.dart';
import 'package:smartpay/presentation/resources/font_manager.dart';
import 'package:smartpay/presentation/resources/strings_manager.dart';
import 'package:smartpay/presentation/resources/styles_manager.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({Key? key}) : super(key: key);

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  final NavigationService _navigationService = instance<NavigationService>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
            ),
         ),
      body: _getContentWidget()
    );
  }

  Widget _getContentWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
        Image.asset(
        ImageAssets.done,
        height: resHeight(AppSize.s134, sHeight),
         width: resWidth(AppSize.s140, sWidth),
      ),
      SizedBox(height: resHeight(AppSize.s23, sHeight),),
      Text(
        "${AppStrings.congrats} ${_appPreferences.getUserName()}",
        style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s24),
      ),
      SizedBox(height: resHeight(AppSize.s13, sHeight),),
      Padding(
           padding: EdgeInsets.only(
            left: resWidth(AppSize.s70, sWidth),
            right: resWidth(AppSize.s70, sWidth)),
        child: Text(
          AppStrings.completed, textAlign: TextAlign.center,
          style: getRegularStyle(color: ColorManager.textColor, fontSize: FontSize.s16),
        ),
      ),
        SizedBox(height: resHeight(AppSize.s33, sHeight),),
      Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: SizedBox(
              width: resWidth(AppSize.s327, sWidth),
              height: AppSize.s50,
              child: ElevatedButton(
                  onPressed:(){
                    _navigationService.navigateReplacementTo(Routes.loginRoute);
                  },
                      child: Text(
                    AppStrings.getStarted,
                    style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s16),
                  )),
            )),
    ],
    );
  }
}