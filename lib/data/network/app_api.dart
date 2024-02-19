

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:smartpay/data/responses/responses.dart';
import 'package:smartpay/models/authentication_models/sign_up_model.dart';


import '../../app/constant.dart';
import '../../models/authentication_models/email_login.dart';


part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)

abstract class AppServiceClient {
  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;
    @POST("/auth/login")
  Future<LoginModel> login(
      @Field("email") String email,
      @Field("password") String password,
      @Field("device_name") String device_name,
      );
 
    @POST("/auth/email")
  Future<SignUp> email(
      @Field("email") String email,
      );

     @POST("/auth/email/verify")
  Future<VerifyEmail> verifyEmail(
      @Field("email") String email,
      @Field("token") String token
      );

  @POST("/auth/register")
  Future<Register> register(
      @Field("fullName") String fullName,
      @Field("email") String email,
      @Field("password") String password,
      @Field("device_name") String device_name,
      @Field("username") String username,
      @Field("country") String country,
      );

}