

import 'dart:async';

import 'package:smartpay/presentation/base/baseviewmodel.dart';

class SignUpViewModel extends BaseViewModel 
with SignUpViewModelInputs, SignUpViewModelOutputs {


  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _otpStreamController = StreamController<String>.broadcast();
  final StreamController _fullNameStreamController = StreamController<String>.broadcast();
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _countryStreamController = StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();


 @override
  void dispose() {
    _emailStreamController.close();
    _otpStreamController.close();
    _fullNameStreamController.close();
    _userNameStreamController.close();
    _countryStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    inputState.close();
  }
  
  @override
  // TODO: implement email
  Sink get email => throw UnimplementedError();
  
  @override
  // TODO: implement fullName
  Sink get fullName => throw UnimplementedError();
  
  @override
  // TODO: implement otp
  Sink get otp => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsFullNameValid
  Stream<bool> get outputIsFullNameValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsOtplValid
  Stream<bool> get outputIsOtplValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid => throw UnimplementedError();
  
  @override
  // TODO: implement password
  Sink get password => throw UnimplementedError();
  
  @override
  setCountry(String country) {
    // TODO: implement setCountry
    throw UnimplementedError();
  }
  
  @override
  setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }
  
  @override
  setFullName(String fullName) {
    // TODO: implement setFullName
    throw UnimplementedError();
  }
  
  @override
  setOtp(int otp) {
    // TODO: implement setOtp
    throw UnimplementedError();
  }
  
  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }
  
  @override
  setUsername(String username) {
    // TODO: implement setUsername
    throw UnimplementedError();
  }
  
  @override
  void start() {
    // TODO: implement start
  }
  
  @override
  // TODO: implement username
  Sink get username => throw UnimplementedError();

}


abstract class SignUpViewModelInputs {
  setEmail(String email);
  setOtp(int otp);
  setFullName(String fullName);
  setUsername(String username);
  setCountry(String country);
  setPassword(String password);


// sinks

  Sink get email;
  Sink get otp;
  Sink get fullName;
  Sink get username;
  Sink get password;

}

abstract class SignUpViewModelOutputs {

  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsOtplValid;
  Stream<bool> get outputIsFullNameValid;
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;



}