import 'package:dartz/dartz.dart';
import 'package:smartpay/data/network/failure.dart';
import 'package:smartpay/domain/usecase/base_usecase.dart';
import 'package:smartpay/models/message_model.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../repository/repository.dart';

class DashboardUseCase implements BasesUseCase<Message> {
   final AppPreferences _appPreferences = instance<AppPreferences>();
  final Repository _repository;

  DashboardUseCase(this._repository);

  @override
  Future<Either<Failure, Message>> execute() async{
   return await _repository.dashboard();
  }


}

class DashbaordCaseInout{
  String message;

  DashbaordCaseInout(this.message);
}
