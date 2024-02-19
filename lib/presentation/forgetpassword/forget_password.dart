import 'dart:async';

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
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;

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
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarColor: ColorManager.primary,
            //   statusBarBrightness: Brightness.dark,
            //   statusBarIconBrightness: Brightness.dark,
            // ),
            leading: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  // _viewModel.inputState.add(null);
                  _navigationService.navigateReplacementTo(Routes.loginRoute);
                },
                icon: Image.asset(
                  ImageAssets.illustration1,
                  height: AppSize.s24,
                  width: AppSize.s24,
                )),
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
            SizedBox(height: resHeight(AppSize.s63, sHeight)),
            Padding(
              padding: EdgeInsets.only(left: resWidth(AppSize.s24, sWidth)),
              child: Text(
                AppStrings.forgotPassword,
                style: getSemiBoldStyle(
                    color: ColorManager.secondary, fontSize: FontSize.s26),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s12, sHeight)),
            Padding(
              padding: EdgeInsets.only(left: resWidth(AppSize.s24, sWidth)),
              child: Text(
                AppStrings.forgotPasswordBodyText,
                style: getRegularStyle(
                    color: ColorManager.landingPageDescriptionColor,
                    fontSize: FontSize.s12),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s59, sHeight)),
            Padding(
              padding: EdgeInsets.only(
                  left: resWidth(AppSize.s24, sWidth),
                  right: resWidth(AppSize.s24, sWidth)),
              child: TextFormField(
                  cursorColor: ColorManager.secondary,
                  style: getRegularStyle(
                      color: ColorManager.textFieldTextColor,
                      fontSize: FontSize.s14),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.mail_lock_outlined,
                          color: ColorManager.secondary),
                      onPressed: () {},
                    ),
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
                    child: ValueListenableBuilder(
                      valueListenable: _isEnabled,
                      builder: (context, isEnabled, child) =>
                          ElevatedButton(
                              onPressed:(){
                         _navigationService.navigateReplacementTo(Routes.verifyyouridentity);
                              },
                              child: Text(
                                AppStrings.sendmemail,
                                style: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s16),
                              )),
                    ))),
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
