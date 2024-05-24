import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetcare/src/core/network/dio_consumer.dart';
import 'package:jetcare/src/core/network/dio_factory.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetcare/src/features/auth/service/auth_web_service.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/profile/data/repo/profile_repo.dart';
import 'package:jetcare/src/features/profile/service/profile_web_service.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // --------------------- Services
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  instance.registerLazySingleton<NetworkService>(() => DioConsumer(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  // --------------------- Cubit
  instance.registerFactory<SplashCubit>(() => SplashCubit());
  instance.registerFactory<LayoutCubit>(() => LayoutCubit());
  instance.registerFactory<ProfileCubit>(() => ProfileCubit(instance()));
  instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  // --------------------- Repo
  instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));
  instance.registerLazySingleton<ProfileRepo>(() => ProfileRepo(instance()));
  // --------------------- Web Service
  instance.registerLazySingleton<AuthWebService>(() => AuthWebService(instance()));
  instance.registerLazySingleton<ProfileWebService>(() => ProfileWebService(instance()));
}
