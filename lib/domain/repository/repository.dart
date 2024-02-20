import 'package:dartz/dartz.dart';
import 'package:smartpay/models/authentication_models/sign_up_model.dart';
import 'package:smartpay/models/message_model.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../../models/authentication_models/email_login.dart';

abstract class Repository {
  Future<Either<Failure,LoginModel>> login(LoginRequest loginRequest);
  Future<Either<Failure,EmailLogin>> loginEmail(LoginRequest loginRequest);
  Future<Either<Failure,SignUp>> email(EmailRequest emailRequest);
  Future<Either<Failure,VerifyEmail>> verifyEmail(VerifyEmailRequest verifyemailRequest);
  Future<Either<Failure,Register>> register(RegisterRequest registerRequest);
  Future<Either<Failure,Message>> dashboard();
}
