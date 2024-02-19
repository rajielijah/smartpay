
import 'dart:developer';

import 'package:dartz/dartz.dart';


import '../../app/app_prefs.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../../models/authentication_models/email_login.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import '../../app/di.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, LoginModel> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(
      LoginUseCaseInput input) async {
    log("logging in with ${_appPreferences.getdevice_name()}");
    return await _repository.login(
        LoginRequest(
            input.email, input.password, await _appPreferences.getdevice_name()
        ));
  }
  Future<Either<Failure, EmailLogin>> executeForEmail(
      LoginUseCaseInput input) async {
    return await _repository.loginEmail(LoginRequest(input.email, input.password, await _appPreferences.getdevice_name()
    ));
  }
  }


class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
