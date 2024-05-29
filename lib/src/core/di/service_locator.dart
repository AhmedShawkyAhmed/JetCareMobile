import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetcare/src/core/network/dio_consumer.dart';
import 'package:jetcare/src/core/network/dio_factory.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/features/address/cubit/address_cubit.dart';
import 'package:jetcare/src/features/address/data/repo/address_repo.dart';
import 'package:jetcare/src/features/address/service/address_web_service.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetcare/src/features/auth/service/auth_web_service.dart';
import 'package:jetcare/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetcare/src/features/crew/data/repo/crew_repo.dart';
import 'package:jetcare/src/features/crew/service/crew_web_service.dart';
import 'package:jetcare/src/features/home/cubit/home_cubit.dart';
import 'package:jetcare/src/features/home/data/repo/home_repo.dart';
import 'package:jetcare/src/features/home/service/home_web_service.dart';
import 'package:jetcare/src/features/language/cubit/language_cubit.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetcare/src/features/notifications/cubit/notification_cubit.dart';
import 'package:jetcare/src/features/notifications/data/repo/notification_repo.dart';
import 'package:jetcare/src/features/notifications/service/notification_web_service.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/profile/data/repo/profile_repo.dart';
import 'package:jetcare/src/features/profile/service/profile_web_service.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetcare/src/features/support/cubit/support_cubit.dart';
import 'package:jetcare/src/features/support/data/repo/support_repo.dart';
import 'package:jetcare/src/features/support/service/support_web_service.dart';

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
  instance.registerFactory<LanguageCubit>(() => LanguageCubit());
  instance.registerFactory<ProfileCubit>(() => ProfileCubit(instance()));
  instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  instance.registerLazySingleton<CrewCubit>(() => CrewCubit(instance()));
  instance.registerFactory<NotificationCubit>(() => NotificationCubit(instance()));
  instance.registerFactory<SupportCubit>(() => SupportCubit(instance()));
  instance.registerFactory<AddressCubit>(() => AddressCubit(instance()));
  instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));

  // --------------------- Repo
  instance.registerLazySingleton<AuthRepo>(() => AuthRepo(instance()));
  instance.registerLazySingleton<ProfileRepo>(() => ProfileRepo(instance()));
  instance.registerLazySingleton<CrewRepo>(() => CrewRepo(instance()));
  instance.registerLazySingleton<NotificationRepo>(() => NotificationRepo(instance()));
  instance.registerLazySingleton<SupportRepo>(() => SupportRepo(instance()));
  instance.registerLazySingleton<AddressRepo>(() => AddressRepo(instance()));
  instance.registerLazySingleton<HomeRepo>(() => HomeRepo(instance()));

  // --------------------- Web Service
  instance.registerLazySingleton<AuthWebService>(() => AuthWebService(instance()));
  instance.registerLazySingleton<ProfileWebService>(() => ProfileWebService(instance()));
  instance.registerLazySingleton<CrewWebService>(() => CrewWebService(instance()));
  instance.registerLazySingleton<NotificationWebService>(() => NotificationWebService(instance()));
  instance.registerLazySingleton<SupportWebService>(() => SupportWebService(instance()));
  instance.registerLazySingleton<AddressWebService>(() => AddressWebService(instance()));
  instance.registerLazySingleton<HomeWebService>(() => HomeWebService(instance()));
}
