import 'package:dartz/dartz.dart';
import 'package:smartpay/data/network/failure.dart';
import 'package:smartpay/data/request/request.dart';
import 'package:smartpay/domain/repository/repository.dart';

import '../../models/authentication_models/sign_up_model.dart';
import 'base_usecase.dart';


class SigUpUseCase implements BaseUseCase<SignUpUsecaseInput, SignUp> {
  final Repository _repository;

  SigUpUseCase(this._repository);

  @override
  Future<Either<Failure, SignUp>> execute(SignUpUsecaseInput input) async{
    return await _repository.email(EmailRequest(input.email));
  }

    Future<Either<Failure, VerifyEmail>> verifyEmail(VerifyEmailUsecaseInput input) async{
    return await _repository.verifyEmail(VerifyEmailRequest(input.email, input.token));
  }
      Future<Either<Failure, Register>> register(RegisterUsecaseInput input) async{
    return await _repository.register(RegisterRequest(input.email, input.password, input.country, input.fullName, input.username, input.device_name));
  }
}

class RegisterUsecaseInput {
  String email;
  String password;
  String token;
  String fullName;
  String country;
  String username;
  String device_name;


  RegisterUsecaseInput(this.email, this.password, this.country, this.device_name, this.fullName, this.token, this.username);
}


class SignUpUsecaseInput {
  String email;
  

  SignUpUsecaseInput(this.email, );
}

class VerifyEmailUsecaseInput {
  String email;
  String token;
  

  VerifyEmailUsecaseInput(this.email, this.token);
}
