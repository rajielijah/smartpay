

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:smartpay/data/responses/responses.dart';


import '../../app/constant.dart';


part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)

abstract class AppServiceClient {
  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;
    @POST("/auth/login")
  Future<AuthenticationBaseResponse> login(
      @Field("email") String email,
      @Field("password") String password,
      @Field("device_name") String device_name,
      );
  // @POST("/api/Auth/Login")
  // Future<EmailLogin> emailLogin(
  //     @Field("otpVia") String otpVia,
  //     @Field("email") String email,
  //     @Field("organizationId") String organizationId,
  //     @Field("password") String password,
  //     @Field("roleId") int roleId,
  //     @Field("device_name") String device_name,
  //     );

}