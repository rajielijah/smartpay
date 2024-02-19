import 'package:smartpay/domain/usecase/dashboard_usecase.dart';
import 'package:smartpay/presentation/base/baseviewmodel.dart';

import '../common/state_renderer/state_render_impl.dart';
import '../common/state_renderer/state_rendere.dart';

class DashboardViewModel extends BaseViewModel 
  with DashbaordOutputs, DashboardInputs{
  final DashboardUseCase _dashboardUseCase;

  DashboardViewModel(this._dashboardUseCase, this.message);

  String message;



@override
  getMessage() async{
    (await _dashboardUseCase.execute())
      .fold((failure) =>  inputState.add(ErrorState(
              StateRendererType.SNACKBAR_ERROR_STATE, failure.message)),
      (data) {
        inputState.add(ContentState());
        message = data.data?.secret ?? "";
      });

  }
  
  @override
  void start() {
    inputState.add(ContentState());
  }
}

abstract class DashboardInputs {
  getMessage();
}

abstract class DashbaordOutputs{}
