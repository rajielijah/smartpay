import 'package:dartz/dartz.dart';
import 'package:smartpay/data/network/failure.dart';
import 'package:smartpay/domain/usecase/base_usecase.dart';
import 'package:smartpay/models/message_model.dart';

import '../repository/repository.dart';

class DashboardUseCase implements BasesUseCase<Message> {
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
