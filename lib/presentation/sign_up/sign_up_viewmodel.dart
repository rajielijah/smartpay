

import 'dart:async';

import 'package:smartpay/domain/usecase/sign_up_usecase.dart';
import 'package:smartpay/presentation/base/baseviewmodel.dart';
import 'package:smartpay/presentation/common/freezed_data_class.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../app/function.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../common/state_renderer/state_rendere.dart';

class SignUpViewModel extends BaseViewModel 
with SignUpViewModelInputs, SignUpViewModelOutputs {


  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _otpStreamController = StreamController<String>.broadcast();
  final StreamController _fullNameStreamController = StreamController<String>.broadcast();
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _countryStreamController = StreamController<String>.broadcast();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  final StreamController _isAllRegisterValidStreamController = StreamController<void>.broadcast();

    StreamController isOtpVerifiedSuccessfullyStreamController =
  StreamController<String>();

  StreamController isEmailVerifiedSuccessfullyStreamController = StreamController<String>();
  StreamController isRegisteredSuccessfullyStreamController = StreamController<String>();


  
    var signupObject = SignUpObject("", "","", "","", "", "");

  final SigUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase);
  


 @override
  void dispose() {
    _emailStreamController.close();
    _otpStreamController.close();
    _fullNameStreamController.close();
    _userNameStreamController.close();
    _countryStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    isOtpVerifiedSuccessfullyStreamController.close();
    inputState.close();
  }

     @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }
  
  @override
  Sink get inputEmail => _emailStreamController.sink;
  
  @override
  Sink get inputFullName => _fullNameStreamController.sink;
  
  @override
  Sink get inputOtp =>_otpStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

 @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputCountry => _countryStreamController.sink;


    @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;



  @override
  email() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    
    (await _signUpUseCase.execute(SignUpUsecaseInput(signupObject.email)))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
            },
            (data) async {
          // right -> success (data)
          inputState.add(ContentState());
         await  _appPreferences.setNewEmail(signupObject.email);
          isEmailVerifiedSuccessfullyStreamController.add("");
          // navigate to main screen after the login
        });
  }
  

   @override
  verifyEmail() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _signUpUseCase.verifyEmail(VerifyEmailUsecaseInput(_appPreferences.getUserEmail(), signupObject.otp)))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
            },
            (data) async {
          // right -> success (data)
          inputState.add(ContentState());
          // navigate to main screen after the login
          isOtpVerifiedSuccessfullyStreamController.add("");
        });
  }
  

   @override
  register() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _signUpUseCase.register(RegisterUsecaseInput(signupObject.full_name,  signupObject.username, _appPreferences.getUserEmail(),
     signupObject.country,  signupObject.password, "web", )))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
            },
            (data) async {
          // right -> success (data)
          inputState.add(ContentState());
          await _appPreferences.setUserName(signupObject.username);
          // navigate to main screen after the login
           isRegisteredSuccessfullyStreamController.add('');
        });
  }
  
  @override
  Stream<bool> get outputIsAllInputsValid => 
  _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());
  
    @override
  Stream<bool> get outputIsRegisterValid => 
  _isAllRegisterValidStreamController.stream.map((_) => _isAllRegisterValid());

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
    .map((email) => isEmailsValid(email));
  
  @override
  Stream<bool> get outputIsFullNameValid => _fullNameStreamController.stream
      .map((fullName) => isFullNameValid(fullName));
  
  @override
  Stream<bool> get outputIsCountryValid => _countryStreamController.stream
      .map((country) => _isPasswordValid(country));
  
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  
  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

    @override
  Stream<bool> get outputIsOtplValid => _otpStreamController.stream
  .map((otp) => _isOTPValid(otp));
  
 
  
  @override
  setCountry(String country) {
   inputCountry.add(country);
    signupObject = signupObject.copyWith(country: country);
  }
  
  @override
  setEmail(String email) {
     inputEmail.add(email);
    signupObject = signupObject.copyWith(email: email);
  }
  
  @override
  setFullName(String full_name) {
    inputFullName.add(full_name);
    signupObject = signupObject.copyWith(full_name: full_name);
  }
  
  @override
  setOtp(String otp) {
    inputOtp.add(otp);
    signupObject = signupObject.copyWith(otp: otp);
    
  }
  
  @override
  setPassword(String password) {
     inputPassword.add(password);
    signupObject = signupObject.copyWith(password: password);
  }
  
  @override
  setUsername(String username) {
    inputUsername.add(username);
    signupObject = signupObject.copyWith(username: username);
    _validate();
    
  }

    bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

    bool isFullNameValid(String fullName) {
    return fullName.isNotEmpty; 
  }

   bool isEmailsValid(String email) {
    return email.isNotEmpty &&(isEmailValid(email)); 
  }
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty && (isEmailValid(userName) || (double.tryParse(userName) != null && userName.length == 11));
  }
  
    bool _isAllInputsValid() {
    return _isPasswordValid(signupObject.password) &&
         isFullNameValid(signupObject.full_name);
  }
  
  bool _isAllRegisterValid() {
    return _isPasswordValid(signupObject.password);
  }

  bool _isOTPValid(String otp) {
    return otp.length == 5;
  }

  _validate() {
    inputIsAllInputValid.add("null");
  }

}



abstract class SignUpViewModelInputs {
  setEmail(String email);
  setOtp(String otp);
  setFullName(String fullName);
  setUsername(String username);
  setCountry(String country);
  setPassword(String password);
  email();
  verifyEmail();
  register();


// sinks

  Sink get inputEmail;
  Sink get inputOtp;
  Sink get inputFullName;
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputCountry;

  Sink get inputIsAllInputValid;


}

abstract class SignUpViewModelOutputs {

  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsOtplValid;
  Stream<bool> get outputIsFullNameValid;
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsCountryValid;
  Stream<bool> get outputIsRegisterValid;




  Stream<bool> get outputIsAllInputsValid;



}