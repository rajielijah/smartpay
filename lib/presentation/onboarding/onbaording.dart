import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/navigation_services.dart';
import '../../app/sizes.dart';
import '../../domain/model/model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../reuseables/WidgetUtils.dart';
import 'onboarding_viewmodel.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final ValueNotifier<bool> _isFinalIndex = ValueNotifier<bool>(false);
  final double _sHeight = WidgetUtils.screenHeight;
  final double _sWidth = WidgetUtils.screenWidth;
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final NavigationService _navigationService = instance<NavigationService>();

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapShot) {
          return _getContentWidget(snapShot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.primary,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.white,
          // appBar: AppBar(
          //   backgroundColor: ColorManager.white,
          //   elevation: AppSize.s0,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //     statusBarColor: ColorManager.primary,
          //     statusBarBrightness: Brightness.dark,
          //     statusBarIconBrightness: Brightness.dark,
          //   ),
          // ),
          body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSlides,
              onPageChanged: (index) {
                index == sliderViewObject.numOfSlides - 1
                    ? _isFinalIndex.value = true
                    : _isFinalIndex.value = false;
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: resHeight(FontSize.s14, _sHeight), right: resHeight(FontSize.s14, _sHeight)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          _navigationService.navigateReplacementTo(Routes.loginRoute);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(AppStrings.skip,  
                          style: getBoldStyle(
                            color: ColorManager.primarybase,
                            fontSize: resHeight(FontSize.s16, _sHeight))),
                        ),
                      ),
                      SizedBox(height: resHeight(AppSize.s70, _sHeight)),
                      Padding(
                           padding: EdgeInsets.only(
                                left: resWidth(AppSize.s24, _sWidth),
                                right: resWidth(AppSize.s24, _sWidth)),
                        child: OnBoardingPage(sliderViewObject.sliderObject),
                      ),
                      SizedBox(
                        height: resHeight(AppSize.s28, _sHeight),
                      ),
                      Column(
                        children: [
                          _getBottomSheetWidget(sliderViewObject),
                          SizedBox(
                            height: resHeight(AppSize.s28, _sHeight),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: resWidth(AppSize.s55, _sWidth),
                                right: resWidth(AppSize.s55, _sWidth)),
                            child: SizedBox(
                                height: resHeight(AppSize.s56, _sHeight),
                                width: resWidth(AppSize.s287, _sWidth),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    AppSize.s22)), backgroundColor: ColorManager.black),
                                    onPressed: () {
                                    _navigationService.navigateReplacementTo(
                                              Routes.loginRoute);
                                         
                                    },
                                    child: Center(
                                            child: Text(
                                              AppStrings.getStarted,
                                              style: getMediumStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s16),
                                            ),
                                          )
                                        )),
                          )
                          // add layout for indicator and arrows
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // circles indicator
          for (int i = 0; i < sliderViewObject.numOfSlides; i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: _getProperCircle(i, sliderViewObject.currentIndex),
            ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return Image.asset(
        ImageAssets.activeCircle,
        height: resHeight(AppSize.s5, _sHeight),
        width: resWidth(AppSize.s30, _sWidth),
      ); // selected slider
    } else {
      return Image.asset(
        ImageAssets.inActiveCircle,
        height: resHeight(AppSize.s5, _sHeight),
        width: resWidth(AppSize.s20, _sWidth),
      ); // unselected slider
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
             
              child: Image.asset(
          _sliderObject.image,
          height: resHeight(AppSize.s190, sHeight),
          width: resWidth(AppSize.s194, sWidth),
        ),),
        Positioned(
          child: Image.asset(
            _sliderObject.image1,
            height: resHeight(AppSize.s189, sHeight),
            width: resWidth(AppSize.s194, sWidth),
              ),
            ),
          ],
        ),
        
        SizedBox(
          height: resHeight(AppSize.s20, sHeight),
        ),
        Text(_sliderObject.title,
            textAlign: TextAlign.center,
            style: getBoldStyle(
                color: ColorManager.black,
                fontSize: resHeight(FontSize.s24, sHeight))),
             SizedBox(
          height: resHeight(AppSize.s20, sHeight),
        ),
          Text(_sliderObject.subtitle,
            textAlign: TextAlign.center,
            style: getRegularStyle(
                color: ColorManager.textColor,
                fontSize: resHeight(FontSize.s14, sHeight))),
      ],
    );
  }
}
