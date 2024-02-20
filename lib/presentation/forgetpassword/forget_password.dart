
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  final double sHeight = WidgetUtils.screenHeight;
  final double sWidth = WidgetUtils.screenWidth;

  final NavigationService _navigationService = instance<NavigationService>();

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            ),
          backgroundColor: ColorManager.white,
          body: _getContentWidget(),
         ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
              padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
             child: Image.asset(
                    ImageAssets.password,
                    height: AppSize.s77,
                    width: AppSize.s90,
                  ),
           ),
            SizedBox(height: resHeight(AppSize.s23, sHeight)),
            Padding(
              padding: EdgeInsets.only(left: resWidth(AppSize.s24, sWidth)),
              child: Text(
                AppStrings.passwordrecovery,
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.s24),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s12, sHeight)),
            Padding(
              padding: EdgeInsets.only(left: resWidth(AppSize.s24, sWidth)),
              child: Text(
                AppStrings.forgotPasswordBodyText,
                style: getRegularStyle(
                    color: ColorManager.textColor,
                    fontSize: FontSize.s16),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s59, sHeight)),
           Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: TextField(
                cursorColor: ColorManager.textColor,
                style: getRegularStyle(
                    color: ColorManager.textFieldTextColor,
                    fontSize: FontSize.s14),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                controller: _emailController, 
                decoration: InputDecoration(
                  fillColor: ColorManager.greyColor,
                  filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(FontSize.s20),
                  borderSide: BorderSide(
                    color: ColorManager.greyColor ,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(FontSize.s20),
                    borderSide:  BorderSide(
                      color: ColorManager.primarybase,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Email",
                  // errorText: (snapshot.data ?? true)
                  //     ? null
                  //     : "Kindly enter a valid email",
                )),
          ),
            SizedBox(height: resHeight(AppSize.s112, sHeight)),
            Padding(
                padding: EdgeInsets.only(
                    left: resWidth(AppPadding.p47, sWidth),
                    right: resWidth(AppPadding.p47, sWidth)),
                child: SizedBox(
                    width: resWidth(AppSize.s282, sWidth),
                    height: AppSize.s50,
                    child: ElevatedButton(
                        onPressed:(){
                         _navigationService.navigateReplacementTo(Routes.verifyyouridentity);
                        },
                        child: Text(
                          AppStrings.sendmemail,
                          style: getBoldStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16),
                        )))),
          ],
        ),
      ),
    );
  }
}
