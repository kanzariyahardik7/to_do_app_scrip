import 'package:app_scrip/repository/login/login_repo.dart';
import 'package:app_scrip/repository/login/login_repo_impl.dart';
import 'package:app_scrip/repository/register/register_repo.dart';
import 'package:app_scrip/repository/register/register_repo_impl.dart';
import 'package:app_scrip/repository/task/task_repo.dart';
import 'package:app_scrip/repository/task/task_repo_impl.dart';
import 'package:app_scrip/repository/user/user_repo.dart';
import 'package:app_scrip/repository/user/user_repo_impl.dart';
import 'package:app_scrip/services/local_database_sqflite/task_database.dart';
import 'package:app_scrip/services/network/network_api_service.dart';
import 'package:app_scrip/view_models/login_view_model.dart';
import 'package:app_scrip/view_models/register_view_model.dart';
import 'package:app_scrip/view_models/task_view_model.dart';
import 'package:app_scrip/view_models/user_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  //-------------------------------- Services --------------------------------
  final Dio dio = Dio();
  getIt.registerLazySingleton<NetworkApiService>(
    () => NetworkApiService(dio: dio),
  );

  getIt.registerLazySingleton<TaskDatabase>(() => TaskDatabase.instance);

  //-------------------------------- Repositories --------------------------------

  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(networkApiService: getIt<NetworkApiService>()),
  );

  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(networkApiService: getIt<NetworkApiService>()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(networkApiService: getIt<NetworkApiService>()),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      networkApiService: getIt<NetworkApiService>(),
      localDb: getIt<TaskDatabase>(),
    ),
  );

  //-------------------------------- ViewModels --------------------------------
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginRepository: getIt<LoginRepository>()),
  );
  getIt.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(registerRepository: getIt<RegisterRepository>()),
  );
  getIt.registerFactory<UserViewModel>(
    () => UserViewModel(userRepository: getIt<UserRepository>()),
  );
  getIt.registerFactory<TaskViewModel>(
    () => TaskViewModel(taskRepository: getIt<TaskRepository>()),
  );
}
