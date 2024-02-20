
// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app/di.dart';
import '../../../app/navigation_services.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  SNACKBAR_ERROR_STATE,
  POPUP_SUCCESS,
  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;
  final NavigationService _navigationService = instance<NavigationService>();

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getErrorMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.POPUP_SUCCESS:
        return _getPopUpDialog(context, [
          _getMessage(title),
          _getAnimatedImage(JsonAssets.success),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getErrorMessage(message),
          _getRetryButton(AppStrings.retry_again, context)
        ]);
      case StateRendererType.SNACKBAR_ERROR_STATE:
        return _snackBarErrorWidget(message);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }
  Widget _snackBarErrorWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: AppSize.s50,
      decoration:  BoxDecoration(
        color: ColorManager.loginLogsRed,
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s15)),
      ),
      child: Center(
        child: Text(
          message,style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s14),
        ),
      ),
    );
  }


  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Padding(
      padding: const EdgeInsets.only(top:AppSize.s8),
      child: SizedBox(
        height: animationName == JsonAssets.error ? AppSize.s50 : AppSize.s100,
        width: animationName == JsonAssets.error ? AppSize.s50 : AppSize.s100,
        child: Lottie.asset(animationName),
      ),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style:
              getMediumStyle(color: ColorManager.secondary, fontSize: FontSize.s14),
        ),
      ),
    );
  }
  Widget _getErrorMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style:
          getMediumStyle(color: ColorManager.errorColor, fontSize: FontSize.s14),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunction
                      ?.call(); // to call the API function again to retry
                }
                else if (stateRendererType ==
                    StateRendererType.POPUP_SUCCESS) {
                  retryActionFunction
                      ?.call(); // to call the API function again to retry
                }
                else {
                  _navigationService.pop(); // popup state error so we need to dismiss the dialog
                }
              },
              child: Text(buttonTitle,style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s14),)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
