import 'package:dio/dio.dart';
import 'package:smartpay/models/authentication_models/sign_up_model.dart';

import '../network/app_api.dart';
import '../request/request.dart';
import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationBaseResponse> login(LoginRequest loginRequest);
  Future<SignUp> email(EmailRequest emailRequest);
  Future<VerifyEmail> verifyEmail(VerifyEmailRequest verifyEmailRequest);
  Future<Register> register(RegisterRequest registerRequest);


}


class RemoteDataSourceImplementer implements RemoteDataSource {
    final AppServiceClient _appServiceClient;

  final Dio dio = Dio();

  RemoteDataSourceImplementer(this._appServiceClient);


  @override
  Future<AuthenticationBaseResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
       loginRequest.email, loginRequest.password, loginRequest.device_name);
  }

  @override
   Future<SignUp> email(EmailRequest emailRequest) async {
    return await _appServiceClient.email(
       emailRequest.email);
  }
  @override
  Future<VerifyEmail> verifyEmail(VerifyEmailRequest verifyEmailRequest) async {
    return await _appServiceClient.verifyEmail(
       verifyEmailRequest.email, verifyEmailRequest.token);
  }

  @override
 Future<Register> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
       registerRequest.fullName, registerRequest.email, registerRequest.password, registerRequest.device_name, registerRequest.username, registerRequest.country);
  }
}