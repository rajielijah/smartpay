import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartpay/presentation/sign_up/sign_up_viewmodel.dart';

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

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
   double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool confirmNotShown = true;


  final AppPreferences _appPreferences = instance<AppPreferences>();
  final NavigationService _navigationService = instance<NavigationService>();
  final SignUpViewModel _viewModel = instance<SignUpViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() async {
    _viewModel.start();
     if(_appPreferences.getUserEmail().isNotEmpty){
      _userNameController.text = _appPreferences.getUserEmail();
      _viewModel.setEmail(_emailController.text);
    }
    _emailController
      .addListener(() => _viewModel.setEmail(_emailController.text));
    _userNameController
      .addListener(() => _viewModel.setUsername(_userNameController.text));
    _countryController
      .addListener(() => _viewModel.setCountry(_countryController.text));
    _fullNameController
      .addListener(() => _viewModel.setFullName(_fullNameController.text));
    _fullNameController
      .addListener(() => _viewModel.setFullName(_fullNameController.text));
    _passwordController
      .addListener(() => _viewModel.setPassword(_passwordController.text));
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
                icon: Icon(Icons.arrow_back_ios, color: ColorManager.black  ,)),
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
                AppStrings.yourself,
                style: getMediumStyle(
                  color: ColorManager.textColor, fontSize: AppSize.s24),textAlign: TextAlign.center,
                        ),
              ),
            ),
          SizedBox(height: resHeight(AppSize.s40, sHeight)),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsFullNameValid,
              builder: (context, snapshot) {
                return TextField(
                    cursorColor: ColorManager.textColor,
                    style: getRegularStyle(
                        color: ColorManager.textFieldTextColor,
                        fontSize: FontSize.s14),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _fullNameController, 
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
                      hintText: "Full Name",
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
              stream: _viewModel.outputIsFullNameValid,
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
                      hintText: "UserName",
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
          SizedBox(height: resHeight(AppSize.s16, sHeight)),
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