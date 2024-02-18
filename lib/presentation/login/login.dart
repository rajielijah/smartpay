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
      token.toString() == "skip" ?
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.navigateReplacementTo(Routes.dashboard);
      }) :
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.navigateReplacementTo(Routes.otpRoute);
      });
    });
  }

    @override
  void initState() {
    _bind();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    // checkInternetConnectivity2();
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
                  // _viewModel.inputState.add(null);
                  _navigationService.navigateReplacementTo(Routes.landingPageRoute);
                },
                icon: Image.asset(
                  ImageAssets.activeCircle,
                  height: AppSize.s24,
                  width: AppSize.s24,
                )),
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
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: resHeight(AppSize.s30, sHeight)),
          SizedBox(
            height: resHeight(AppSize.s44, sHeight),
          ),
          Center(
              child: Text(
            AppStrings.hi,
            style: getSemiBoldStyle(
                color: ColorManager.stateRendererTextColor, fontSize: 16),textAlign: TextAlign.center,
          )),
          SizedBox(height: resHeight(AppSize.s4, sHeight)),
            Center(
              child: Text(
            AppStrings.welcome,
            style: getMediumStyle(
                color: ColorManager.stateRendererTextColor, fontSize: 16),textAlign: TextAlign.center,
          )),
          SizedBox(height: resHeight(AppSize.s40, sHeight)),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsUserNameValid,
              builder: (context, snapshot) {
                return TextFormField(
                    cursorColor: ColorManager.secondary,
                    style: getRegularStyle(
                        color: ColorManager.textFieldTextColor,
                        fontSize: FontSize.s14),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      labelText: "Email",
                      errorText: (snapshot.data ?? true)
                          ? null
                          : "Kindly enter a valid email",
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
                        hintText: AppStrings.hintPassword,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError),
                  );
                });
              },
            ),
          ),
          SizedBox(height: resHeight(AppSize.s16, sHeight)),
          Center(
            child: TextButton(
              onPressed: () {
                _navigationService.navigateReplacementTo(Routes.forgetpassword);
              },
              child: Text(AppStrings.forgetPassword,
                  style: getRegularStyle(
                      color: ColorManager.greenbase,
                      fontSize: FontSize.s14)),
            ),
          ),
          SizedBox(height: resHeight(AppSize.s35, sHeight)),
          Padding(
              padding: EdgeInsets.only(
                  left: resWidth(AppSize.s67, sWidth),
                  right: resWidth(AppSize.s67, sWidth)),
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
            height: resHeight(AppSize.s65, sHeight),
          ),
          Center(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigationService.navigateReplacementTo(Routes.signUpRoute);
                  },
                  child: Text(AppStrings.signUpNew,
                      style: getMediumStyle(
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