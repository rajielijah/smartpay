import 'package:dio/dio.dart';

import '../network/app_api.dart';
import '../request/request.dart';
import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationBaseResponse> login(LoginRequest loginRequest);

}


class RemoteDataSourceImplementer implements RemoteDataSource {
    final AppServiceClient _appServiceClient;

  final Dio dio = Dio();

  RemoteDataSourceImplementer(this._appServiceClient);


  @override
  Future<AuthenticationBaseResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
       loginRequest.email, loginRequest.password, loginRequest.deviceToken);
  }

}