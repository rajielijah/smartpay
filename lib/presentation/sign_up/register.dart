import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:smartpay/presentation/sign_up/sign_up_viewmodel.dart';

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
    _emailController
      .addListener(() => _viewModel.setEmail(_emailController.text));
    _userNameController
      .addListener(() => _viewModel.setUsername(_userNameController.text));
    _countryController
      .addListener(() => _viewModel.setCountry(_countryController.text));
    _fullNameController
      .addListener(() => _viewModel.setFullName(_fullNameController.text));
    _passwordController
      .addListener(() => _viewModel.setPassword(_passwordController.text));

      _viewModel.isRegisteredSuccessfullyStreamController.stream
        .listen((token) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
        resetModules();
        _navigationService.navigateReplacementTo(Routes.congratulations);
      });
        });
  }

   @override
  void initState() {
    _bind();
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
                  _navigationService.navigateReplacementTo(Routes.loginRoute);
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
              padding:  EdgeInsets.only(
                  left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
              child: Row(
                children: [
                  Text(
                    AppStrings.abit,
                    style: getBoldStyle(
                      color: ColorManager.black, fontSize: AppSize.s24),textAlign: TextAlign.center,
                       ),
                ],
              ),
            ),
          Padding(
            padding:  EdgeInsets.only(
                 left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: Row(
              children: [
                Text(
                AppStrings.about,
                style: getBoldStyle(
                  color: ColorManager.black, fontSize: AppSize.s24),textAlign: TextAlign.center,
                   ),
                Text(
                AppStrings.yourself,
                style: getBoldStyle(
                  color: ColorManager.greenbase, fontSize: AppSize.s24),textAlign: TextAlign.center,
                   ),
              ],
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
              stream: _viewModel.outputIsUsernameValid,
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
              stream: _viewModel.outputIsCountryValid,
              builder: (context, snapshot) {
                return TextField(
                    cursorColor: ColorManager.textColor,
                    style: getRegularStyle(
                        color: ColorManager.textFieldTextColor,
                        fontSize: FontSize.s14),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _countryController, 
                     readOnly: true, // Prevents the keyboard from appearing
                     onTap: _showCountryPicker,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down, color: ColorManager.black,),
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
                      hintText: "Country",
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
          SizedBox(height: resHeight(AppSize.s24, sHeight)),
           Padding(
              padding: EdgeInsets.only(
                  left: resWidth(AppSize.s24, sWidth),
                  right: resWidth(AppSize.s24, sWidth)),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
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
                                      _viewModel.register();
                                      _timer = Timer(
                                          const Duration(milliseconds: 200),
                                          () => _isEnabled.value = true);
                                    }
                                  : null,
                          child: Text(
                            AppStrings.continued,
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16),
                          )),
                    ),
                  );
                },
              )),
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

  final Map<String, String> _countries = {
    'USA': 'US',
    'Canada': 'CA',
    'Mexico': 'MX',
    'Germany': 'DE',
    'France': 'FR',
    'Italy': 'IT',
  };

 void _showCountryPicker() {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    elevation: 10.0,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          color: Colors.white, 
        ),
        child: ListView.builder(
          itemCount: _countries.length,
          itemBuilder: (BuildContext context, int index) {
            String countryName = _countries.keys.elementAt(index);
            return ListTile(
              title: Text(
                 countryName,
                style: const TextStyle(
                  fontSize: AppSize.s18, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.flag), 
              onTap: () {
                String countryCode = _countries[countryName]!;
                  _countryController.text = countryCode;
                  Navigator.pop(context);
              },
            );
          },
        ),
      );
    },
  );
}
String formatCountryName(String countryName) {
    List<String> words = countryName.split(' ');
    if (words.length == 1) {
      return "$countryName Country";
    }
    return countryName;
  }

  }
