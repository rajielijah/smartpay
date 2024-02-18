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

    Future<Either<Failure, VerifyEmail>> verifyEmail(SignUpUsecaseInput input) async{
    return await _repository.verifyEmail(VerifyEmailRequest(input.email, input.token));
  }
      Future<Either<Failure, Register>> register(SignUpUsecaseInput input) async{
    return await _repository.register(RegisterRequest(input.email, input.password, input.country, input.fullName, input.username, input.device_name));
  }
}

class SignUpUsecaseInput {
  String email;
  String password;
  int token;
  String fullName;
  String country;
  String username;
  String device_name;


  SignUpUsecaseInput(this.email, this.password, this.country, this.device_name, this.fullName, this.token, this.username);
}
