import 'package:dartz/dartz.dart';
import 'package:smartpay/data/network/failure.dart';
import 'package:smartpay/data/request/request.dart';
import 'package:smartpay/domain/repository/repository.dart';
import 'package:smartpay/models/authentication_models/email_login.dart';
import 'package:smartpay/models/authentication_models/sign_up_model.dart';
import 'package:smartpay/models/message_model.dart';
import '../../app/di.dart';

import '../../app/app_prefs.dart';
import '../../app/function.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;

   final AppPreferences _appPreferences = instance<AppPreferences>();

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
     if (await checkInternetConnectivity()) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.TRUE) // success
            {
              _appPreferences.getdevice_name();
          // return data (success)
          // return right
          return Right(response);
        } else {
          // return biz logic error
          // return left
          return Left(Failure(int.parse(response.message ?? "0"),
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler
            .handle(error)
            .failure));
      }
    }
     else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
    
  }

  @override
  Future<Either<Failure, EmailLogin>> loginEmail(LoginRequest loginRequest) {
    // TODO: implement loginEmail
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, SignUp>> email(EmailRequest emailRequest) async{
  if (await checkInternetConnectivity()) {
      // try {
        // its safe to call the API
        final response = await _remoteDataSource.email(emailRequest);

        if (response.status == ApiInternalStatus.TRUE) // success
            {
              _appPreferences.getdevice_name();
          // return data (success)
          // return right
          return Right(response);
        } else {
          // return biz logic error
          // return left
          return Left(Failure(int.parse(response.message ?? "0"),
              response.message ?? ResponseMessage.DEFAULT));
        }
      } 
      // catch (error) {
      //   print("here is the $error");
      //   return (Left(ErrorHandler
      //       .handle(error)
      //       .failure));
      // }
    // } 
    else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, Register>> register(RegisterRequest registerRequest) async {
    if (await checkInternetConnectivity()) {
      // try {
        // its safe to call the API
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.TRUE) // success
            {
              _appPreferences.getdevice_name();
          // return data (success)
          // return right
          return Right(response);
        } else {
          // return biz logic error
          // return left
          return Left(Failure(int.parse(response.message ?? "0"),
              response.message ?? ResponseMessage.DEFAULT));
        }
      } 
    //   catch (error) {
    //     return (Left(ErrorHandler
    //         .handle(error)
    //         .failure));
    //   }
    // } 
    else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, VerifyEmail>> verifyEmail(VerifyEmailRequest verifyemailRequest) async {
   if (await checkInternetConnectivity()) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.verifyEmail(verifyemailRequest);

        if (response.status == ApiInternalStatus.TRUE) // success
            {
              _appPreferences.getdevice_name();
          // return data (success)
          // return right
          return Right(response);
        } else {
          // return biz logic error
          // return left
          return Left(Failure(int.parse(response.message ?? "0"),
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler
            .handle(error)
            .failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> dashboard() async {

     if (await checkInternetConnectivity()) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.dashboard();

        if (response.status == ApiInternalStatus.TRUE) // success
            {
           
           // return data (success)
          // return right
          return Right(response);
        } else {
          // return biz logic error
          // return left
          return Left(Failure(int.parse(response.message ?? "0"),
              response.message ?? ResponseMessage.DEFAULT));
        }
      } 
      catch (error) {
        return (Left(ErrorHandler
            .handle(error)
            .failure));
      }
    } 
    else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

}