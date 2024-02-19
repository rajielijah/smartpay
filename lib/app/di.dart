import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/domain/usecase/dashboard_usecase.dart';
import 'package:smartpay/domain/usecase/sign_up_usecase.dart';
import 'package:smartpay/presentation/dashboard/dashboard_viewmodel.dart';
import 'package:smartpay/presentation/sign_up/sign_up_viewmodel.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/login_usecase.dart';
import '../presentation/login/login_viewmodel.dart';
import 'app_prefs.dart';
import 'navigation_services.dart';


final instance = GetIt.instance;


Future<void> initAppModule() async {

   final sharedPrefs = await SharedPreferences.getInstance();

     // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);


  //navigation service instance

  instance.registerLazySingleton<NavigationService>(() => NavigationService());

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));


  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance()));


  callModules();

}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initSignUpModule() {
  if (!GetIt.I.isRegistered<SigUpUseCase>()) {
    instance.registerFactory<SigUpUseCase>(() => SigUpUseCase(instance()));
    instance.registerFactory<SignUpViewModel>(() => SignUpViewModel(instance()));
  }
}

initDashboardModule() {
  if (!GetIt.I.isRegistered<DashboardUseCase>()) {
    instance.registerFactory<DashboardUseCase>(() => DashboardUseCase(instance()));
    instance.registerFactory<DashboardViewModel>(() => DashboardViewModel(instance(), ''));
  }
}

callModules() {
  initLoginModule();
  initSignUpModule();
  initDashboardModule();
}

resetModules() {
  resetDioFactory();
  initSignUpModule();
  initLoginModule();

}

void resetDioFactory() async{
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.unregister<SharedPreferences>();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.unregister<DioFactory>();
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  instance.unregister<AppServiceClient>();
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.unregister<RemoteDataSource>();
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));

  // repository
  instance.unregister<Repository>();
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance()));
}