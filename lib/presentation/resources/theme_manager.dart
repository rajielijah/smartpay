
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pinput/pinput.dart';
import 'package:smartpay/presentation/resources/styles_manager.dart';
import 'package:smartpay/presentation/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.secondary,
      disabledColor: ColorManager.grey,
      // ripple color
      splashColor: ColorManager.secondary.withOpacity(0.15),
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: 0.0,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,)
      ),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey,
          buttonColor: ColorManager.primaryButtonColor,
          splashColor: ColorManager.primaryButtonColor),


      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.primaryButtonColor,
              disabledForegroundColor: ColorManager.primaryButtonColor.withOpacity(0.38), disabledBackgroundColor: ColorManager.primaryButtonColor.withOpacity(0.12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s5)))),


      // pin put theme
      // Text theme
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.secondary, fontSize: FontSize.s16),
          displayMedium: getSemiBoldStyle(
              color: ColorManager.secondary, fontSize: FontSize.s16),
          displaySmall:
          getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color:  ColorManager.stateRendererTextColor, fontSize: FontSize.s14),
          titleSmall: getRegularStyle(
              color:  ColorManager.stateRendererTextColor, fontSize: FontSize.s14),
          bodyMedium: getMediumStyle(color: ColorManager.stateRendererTextColor),
          bodySmall: getRegularStyle(color: ColorManager.stateRendererTextColor),
          bodyLarge: getRegularStyle(color: ColorManager.stateRendererTextColor)),
      // input decoration theme (text form field)


      inputDecorationTheme: InputDecorationTheme(
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.authPlaceholderTextColor),

        // label style
        labelStyle: getRegularStyle(color: ColorManager.authPlaceholderTextColor,fontSize: FontSize.s12),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.borderColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s5))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.borderColor.withOpacity(AppSize.s0_5),width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s5))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s5))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.borderColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s5))),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.oneCareGreen2));
}

final defaultPinTheme = PinTheme(
  width: AppSize.s45,
  height: AppSize.s45,
  textStyle: TextStyle(fontSize: FontSize.s14, color: ColorManager.textFieldTextColor, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: ColorManager.borderColor),
    borderRadius: BorderRadius.circular(AppSize.s5),
  ),
);
final errorPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: ColorManager.error),
  borderRadius: BorderRadius.circular(AppSize.s5),
);
final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: ColorManager.borderColor.withOpacity(AppSize.s0_5)),
  borderRadius: BorderRadius.circular(AppSize.s5),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
      color:ColorManager.white
  ),
);


