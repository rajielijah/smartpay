import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:smartpay/presentation/sign_up/sign_up_viewmodel.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/theme_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView>  createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  double sHeight = WidgetUtils.screenHeight;
  double sWidth = WidgetUtils.screenWidth;
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();


  final SignUpViewModel _viewModel = instance<SignUpViewModel>();
  final NavigationService _navigationService = instance<NavigationService>();

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
     if(_appPreferences.getUserEmail().isNotEmpty){
      _emailController.text = _appPreferences.getUserEmail();
      _viewModel.setEmail(_emailController.text);
    }
    _otpController.addListener(() => _viewModel.setOtp(_otpController.text));
    _viewModel.isOtpVerifiedSuccessfullyStreamController.stream.listen((token) {
      // navigate to register screen
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.navigateReplacementTo(Routes.register);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  _navigationService.navigateReplacementTo(Routes.signUpRoute);
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
        ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: resHeight(AppSize.s63, sHeight)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  AppStrings.verify,
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s24),
                ),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s12, sHeight)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  AppStrings.otpDesc,
                  style: getRegularStyle(
                      color: ColorManager.textColor,
                      fontSize: FontSize.s12),
                ),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s74, sHeight)),
            _getPinPutWidget(),
            SizedBox(height: resHeight(AppSize.s35, sHeight)),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(AppStrings.resendOtp,
                    style: getMediumStyle(
                        color: ColorManager.textColor,
                        fontSize: FontSize.s13)),
              ),
            ),
            SizedBox(height: resHeight(AppSize.s100, sHeight)),
            StreamBuilder<bool>(
              stream: _viewModel.outputIsOtplValid,
              builder: (context, snapshot) {
                return SizedBox(
                    width: resWidth(AppSize.s282, sWidth),
                    height: AppSize.s50,
                    child: ValueListenableBuilder(
                      valueListenable: _isEnabled,
                      builder: (context, isEnabled, child) =>
                          ElevatedButton(
                              onPressed: ((snapshot.data ?? false) &&
                                      _isEnabled.value)
                                  ? () {
                                      _isEnabled.value = false;
                                      _viewModel.verifyEmail();
                                         _timer = Timer(
                                          const Duration(milliseconds: 200),
                                          () => _isEnabled.value = true);
                                    }
                                  : null,
                              child: Text(
                                AppStrings.confirm,
                                style: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s16),
                              )),
                    ));
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPinPutWidget() {
    return Pinput(
      autofocus: true,
      showCursor: true,
      controller: _otpController,
      length: PinPutLength.pl5,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      validator: (value) =>
          value?.length != PinPutLength.pl5 ? AppStrings.otpError : null,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
