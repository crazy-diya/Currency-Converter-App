import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/data/datasources/remote_datasource.dart';
import '../../features/data/datasources/shared_preference.dart';
import '../../features/data/repository/repository_impl.dart';
import '../../features/domain/repository/repository.dart';
import '../../features/domain/usecases/splash_usecase.dart';
import '../../features/presentation/bloc/exchanger/exchanger_cubit.dart';
import '../../features/presentation/bloc/splash/splash_cubit.dart';
import '../network/api_helper.dart';
import '../network/network_info.dart';

final injection = GetIt.instance;

Future<dynamic> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(dio: injection()));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: injection()));


  injection.registerSingleton(AppSharedData(injection()));

  //RemoteDataSource
  injection.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(apiHelper: injection()));

  //Repository
  injection
      .registerLazySingleton<Repository>(() => RepositoryImpl(remoteDatasource: injection(), networkInfo: injection()));

  //UseCase
  injection.registerLazySingleton(() => Splash(repository: injection()));

  //Bloc
  injection.registerFactory(() => SplashCubit(splash: injection()));
  injection.registerFactory(() => ExchangerCubit(splash: injection()));
}
