import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartpay/presentation/sign_up/sign_up_viewmodel.dart';

import '../../app/di.dart';
import '../../app/function.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';

class EmailView extends StatefulWidget {
  const EmailView({Key? key}) : super(key: key);

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  final Connectivity _connectivity = Connectivity();
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
    final NavigationService _navigationService = instance<NavigationService>();

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SignUpViewModel _viewModel = instance<SignUpViewModel>();

  _bind() async {
    _viewModel.start();
    _viewModel.setEmail(_emailController.text);

    _emailController
      .addListener(() => _viewModel.setEmail(_emailController.text));
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
          _navigationService.navigateReplacementTo(Routes.loginRoute);
        },
        icon: Icon(Icons.arrow_back_ios, color: ColorManager.black  ,)),
      ),
       backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return _getContentWidget();
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
                AppStrings.create,
                style: getSemiBoldStyle(
                color: ColorManager.black, fontSize: FontSize.s24),textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: resHeight(AppSize.s40, sHeight)),
          Padding(
            padding: EdgeInsets.only(
                left: resWidth(AppSize.s24, sWidth),
                right: resWidth(AppSize.s24, sWidth)),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsEmailValid,
              builder: (context, snapshot) {
                return TextField(
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
                                      _viewModel.email();
                                      _timer = Timer(
                                          const Duration(milliseconds: 200),
                                          () => _isEnabled.value = true);
                                    }
                                  : null,
                          child: Text(
                            AppStrings.signUp,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.already,
                      style: getMediumStyle(
                          color: ColorManager.textColor,
                          fontSize: FontSize.s13)),
                GestureDetector(
                  onTap: () {
                    _navigationService.navigateReplacementTo(Routes.loginRoute);
                  },
                  child: Text(AppStrings.signin,
                      style: getBoldStyle(
                          color: ColorManager.greenbase,
                          fontSize: FontSize.s13)),
                ),
              ],
            ),
          )
      ],
    ));
}
 @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer?.cancel();
    _emailController.dispose();
    _isEnabled.dispose();
    _viewModel.dispose();
    super.dispose();
  }

}