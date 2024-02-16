


import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../../models/authentication_models/email_login.dart';
import '../model/model.dart';

abstract class Repository {

  Future<Either<Failure,AuthenticationBase>> login(LoginRequest loginRequest);
  Future<Either<Failure,EmailLogin>> loginEmail(LoginRequest loginRequest);


}
