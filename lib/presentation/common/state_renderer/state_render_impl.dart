
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:smartpay/presentation/common/state_renderer/state_rendere.dart';

import '../../../app/di.dart';
import '../../../app/navigation_services.dart';
import '../../../data/mapper/mapper.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
  String getRoute();
  final NavigationService _navigationService = instance<NavigationService>();
}

// Loading State (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getRoute() {
    // TODO: implement getOnTap
    throw UnimplementedError();
  }
}

// error state (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getRoute()  {
    // TODO: implement getOnTap
    throw UnimplementedError();
  }
}

// CONTENT STATE

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getRoute()  {
    // TODO: implement getOnTap
    throw UnimplementedError();
  }
}
class ContentState2 extends FlowState {
  ContentState2();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getRoute()  {
    // TODO: implement getOnTap
    throw UnimplementedError();
  }
}

// EMPTY STATE

class EmptyState extends FlowState {

  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;

  @override
  String getRoute()  {
    // TODO: implement getOnTap
    throw UnimplementedError();
  }
}

// success state
class SuccessState extends FlowState {
  String message;
  String route;

  SuccessState(this.message,{this.route = EMPTY});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;

  @override
  String getRoute()  => route;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          } else // StateRendererType.FULL_SCREEN_LOADING_STATE
              {
            dismissDialog(context);
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          }
          if (getStateRendererType() == StateRendererType.SNACKBAR_ERROR_STATE) {
            // showing popup dialog
            showSnackBar(context, getStateRendererType(), getMessage());
            // return the content ui of the screen
            return contentScreenWidget;
          }
          else // StateRendererType.FULL_SCREEN_ERROR_STATE
              {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case ContentState2:
        {
          // dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case SuccessState:
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // show popup
          showPopUpTemp(context, StateRendererType.POPUP_SUCCESS, getMessage(),
              title: AppStrings.smartpay,route: getRoute());

          // return content ui of the screen
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      _navigationService.pop();
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message,{String title = EMPTY}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {

          },
        )));
  }
  showSnackBar(BuildContext context, StateRendererType stateRendererType,
      String message,{String title = EMPTY}) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            content: StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: () {

              },
        ))));
  }
  showPopUpTemp(BuildContext context, StateRendererType stateRendererType,
      String message,{String title = EMPTY,String route = EMPTY}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {
            if(route.isEmpty){
              _navigationService.pop();
            }
            else{
              _navigationService.pop();
              _navigationService.navigateReplacementTo(route);
            }
          },
        )));
  }
}
