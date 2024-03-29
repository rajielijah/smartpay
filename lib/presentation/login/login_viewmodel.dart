

import 'dart:async';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/function.dart';
import '../../domain/usecase/login_usecase.dart';
import '../base/baseviewmodel.dart';
import '../common/freezed_data_class.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../common/state_renderer/state_rendere.dart';

class LoginViewModel extends BaseViewModel 
  with LoginViewModelInputs, LoginViewModelOutputs {

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController = StreamController<String>();
  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    inputState.close();
  }

   @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    (await _loginUseCase
        .execute(LoginUseCaseInput(loginObject.email, loginObject.password)))
        .fold(
            (failure)  {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message));
            },
            (data) async {
           // right -> success (data)
              inputState.add(ContentState());
              _appPreferences.setUserEmail(loginObject.email);
          // navigate to main screen after the login
              isUserLoggedInSuccessfullyStreamController.add("");
       });
  }

  @override
  setPassword(String password) {
    // password.replaceAll(" ", "");
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    // userName.replaceAll(" ", "");
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        email: userName); // data class operation same as kotlin
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions

  _validate() {
    inputIsAllInputValid.add("null");
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty && (isEmailValid(userName) || (double.tryParse(userName) != null && userName.length == 11));
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.email);
  }
}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

  // two sinks for streams
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
