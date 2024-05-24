import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetcare/src/core/network/dio_consumer.dart';
import 'package:jetcare/src/core/network/dio_factory.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/features/auth/cubit/authenticate_cubit.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
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
  instance.registerFactory<ProfileCubit>(() => ProfileCubit(instance()));
  instance
      .registerFactory<AuthenticateCubit>(() => AuthenticateCubit(instance()));
  // instance.registerFactory<AppCubit>(() => AppCubit());
  // instance.registerFactory<AddressCubit>(() => AddressCubit(instance()));
  // instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  // instance.registerFactory<CalenderCubit>(() => CalenderCubit(instance()));
  // instance.registerFactory<CartCubit>(() => CartCubit(instance()));
  // instance.registerFactory<DetailsCubit>(() => DetailsCubit(instance()));
  // instance.registerFactory<GlobalCubit>(() => GlobalCubit(instance()));
  // instance.registerFactory<LanguageCubit>(() => LanguageCubit());
  // instance
  //     .registerFactory<NotificationCubit>(() => NotificationCubit(instance()));
  // instance.registerFactory<OrderCubit>(() => OrderCubit(instance()));
}
