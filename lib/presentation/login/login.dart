import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/function.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool confirmNotShown = true;

  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final NavigationService _navigationService = instance<NavigationService>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() async{
    _viewModel.start();
    if(_appPreferences.getUserEmail().isNotEmpty){
      _userNameController.text = _appPreferences.getUserEmail();
      _viewModel.setUserName(_userNameController.text);
    }
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((token) {
      // navigate to dashboard
     SchedulerBinding.instance.addPostFrameCallback((_) {
        resetModules();
        _navigationService.navigateReplacementTo(Routes.dashboard);
      });
    });
  }

    @override
  void initState() {
    _bind();
    //Check for internet connectivity
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

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
         leading: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  _navigationService.navigateReplacementTo(Routes.onBoardingRoute);
                },
                icon: Container(
                  height: AppSize.s40,
                  width: AppSize.s40,
                  decoration: BoxDecoration(
                    border:  Border.all(color: ColorManager.greyBorder),
                    borderRadius: BorderRadius.circular(AppSize.s12) ,
                   ),
                  child: Padding(
                     padding: EdgeInsets.only(
                left: resWidth(AppSize.s4, sWidth),
                ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_back_ios, 
                      size: AppSize.s14,
                      color: ColorManager.primaryButtonColor,)),
                  ))),
              ),
           backgroundColor: ColorManager.white,
           body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            },
          ),
        );
  }

   Widget _getContentWidget() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          SizedBox(height: resHeight(AppSize.s30, sHeight)),
          Padding(
             padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppStrings.hi,
                style: getSemiBoldStyle(
                color: ColorManager.black, fontSize: FontSize.s24),textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: resHeight(AppSize.s14, sHeight)),
            Padding(
               padding: EdgeInsets.only(
                left: resWidth(AppSize.s20, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
              child: Align(
              alignment: Alignment.topLeft,
                child: Text(
                AppStrings.welcome,
                style: getRegularStyle(
                  color: ColorManager.textColor, fontSize: 16),textAlign: TextAlign.center,
                        ),
              ),
            ),
          SizedBox(height: resHeight(AppSize.s40, sHeight)),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsUserNameValid,
              builder: (context, snapshot) {
                return TextField(
                    cursorColor: ColorManager.textColor,
                    style: getRegularStyle(
                        color: ColorManager.textFieldTextColor,
                        fontSize: FontSize.s14),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _userNameController, 
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
                     ));
              },
            ),
          ),
          SizedBox(
            height: resHeight(AppSize.s24, sHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsPasswordValid,
              builder: (context, snapshot) {
                return StatefulBuilder(builder: (context, setNewState) {
                  return TextFormField(
                    cursorColor: ColorManager.secondary,
                    style: getRegularStyle(
                        color: ColorManager.textFieldTextColor,
                        fontSize: FontSize.s14),
                    textInputAction: TextInputAction.done,
                    obscureText: confirmNotShown,
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: confirmNotShown
                              ? Image.asset(
                                  ImageAssets.invisibleIcon,
                                  height: resHeight(AppSize.s24, sHeight),
                                  width: resWidth(AppSize.s24, sWidth),
                                )
                              : Image.asset(
                                  ImageAssets.visibleIcon,
                                  height: resHeight(AppSize.s24, sHeight),
                                  width: resWidth(AppSize.s24, sWidth),
                                ),
                          onPressed: () {
                            setNewState(() {
                              confirmNotShown = !confirmNotShown;
                            });
                          },
                        ),
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
                        hintText: AppStrings.hintPassword,
                    ),
                  );
                });
              },
            ),
          ),
          SizedBox(height: resHeight(AppSize.s10, sHeight)),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),  
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  _navigationService.navigateReplacementTo(Routes.forgotPassword);
                },
                child: Text(AppStrings.forgetPassword,
                    style: getBoldStyle(
                        color: ColorManager.greenbase,
                        fontSize: FontSize.s14)),
              ),
            ),
          ),
          SizedBox(height: resHeight(AppSize.s10, sHeight)),
          Padding(
              padding: EdgeInsets.only(
                  left: resWidth(AppSize.s24, sWidth),
                  right: resWidth(AppSize.s24, sWidth)),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsAllInputsValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: resWidth(AppSize.s241, sWidth),
                    height: AppSize.s50,
                    child: ValueListenableBuilder(
                      valueListenable: _isEnabled,
                      builder: (context, isEnabled, child) => ElevatedButton(
                          onPressed:
                              ((snapshot.data ?? false) && _isEnabled.value)
                                  ? () {
                                      _isEnabled.value = false;
                                      _viewModel.login();
                                      _timer = Timer(
                                          const Duration(milliseconds: 200),
                                          () => _isEnabled.value = true);
                                    }
                                  : null,
                          child: Text(
                            AppStrings.signin,
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16),
                          )),
                    ),
                  );
                },
              )),
           SizedBox(
            height: resHeight(AppSize.s35, sHeight),
          ),
          Center(
            child: Text(AppStrings.or, 
          style: getRegularStyle(color: ColorManager.textColor),
          )),      
           SizedBox(
            height: resHeight(AppSize.s35, sHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: resWidth(AppSize.s24, sWidth),
              right: resWidth(AppSize.s24, sWidth)),
            child: Row(
              children: [
                Container(
                  height: resHeight(AppSize.s56, sHeight),
                  width: resWidth(AppSize.s155, sWidth),
                  decoration: BoxDecoration(
                      border:  Border.all(color: ColorManager.greyBorder),
                      borderRadius: BorderRadius.circular(AppSize.s12) ,
                     ),
                   child: Image.asset(ImageAssets.google),  
                ),
                SizedBox(width: resWidth(AppSize.s12, sWidth),),
                 Container(
                  height: resHeight(AppSize.s56, sHeight),
                  width: resWidth(AppSize.s155, sWidth),
                  decoration: BoxDecoration(
                      border:  Border.all(color: ColorManager.greyBorder),
                      borderRadius: BorderRadius.circular(AppSize.s12) ,
                     ),
                    child: Image.asset(ImageAssets.apple),  
                )
              ],
            ),
          ),    
          SizedBox(
            height: resHeight(AppSize.s115, sHeight),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.signUpNew,
                      style: getMediumStyle(
                          color: ColorManager.textColor,
                          fontSize: FontSize.s13)),
                GestureDetector(
                  onTap: () {
                    _navigationService.navigateReplacementTo(Routes.signUpRoute);
                  },
                  child: Text(AppStrings.signUp,
                      style: getBoldStyle(
                          color: ColorManager.greenbase,
                          fontSize: FontSize.s13)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer?.cancel();
    _userNameController.dispose();
    _passwordController.dispose();
    _isEnabled.dispose();
    _viewModel.dispose();
    super.dispose();
  }

}