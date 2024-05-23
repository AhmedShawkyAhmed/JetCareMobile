import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetcare/src/business_logic/cart_cubit/cart_cubit.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/network/dio_factory.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // --------------------- Services
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  // --------------------- Cubit
  instance.registerFactory<AppCubit>(() => AppCubit());
  instance.registerFactory<AddressCubit>(() => AddressCubit(instance()));
  instance.registerFactory<AuthCubit>(() => AuthCubit(instance()));
  instance.registerFactory<CalenderCubit>(() => CalenderCubit(instance()));
  instance.registerFactory<CartCubit>(() => CartCubit(instance()));
  instance.registerFactory<DetailsCubit>(() => DetailsCubit(instance()));
  instance.registerFactory<GlobalCubit>(() => GlobalCubit(instance()));
  instance.registerFactory<LanguageCubit>(() => LanguageCubit());
  instance
      .registerFactory<NotificationCubit>(() => NotificationCubit(instance()));
  instance.registerFactory<OrderCubit>(() => OrderCubit(instance()));
}
