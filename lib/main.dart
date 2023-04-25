import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:jetcare/src/business_logic/bloc_observer.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/language_cubit/language_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetcare/src/presentation/router/app_router.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

late LocalizationDelegate delegate;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      final locale = CacheHelper.getDataFromSharedPreference(
              key: SharedPreferenceKeys.language) ??
          "ar";
      CacheHelper.saveDataSharedPreference(
          key: SharedPreferenceKeys.language, value: locale);
      delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));
      runApp(
        MyApp(appRouter: AppRouter()),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        DefaultToast.showMyToast(e.toString());
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => AuthCubit())),
        BlocProvider(create: ((context) => AppCubit())),
        BlocProvider(
            create: ((context) => GlobalCubit()
              ..getHome()
              ..getInfo()
              ..getArea()
              ..getPeriods())),
        CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.role) ==
                "client"
            ? BlocProvider(
                create: ((context) => OrderCubit()
                  ..getMyOrders()))
            : BlocProvider(
                create: ((context) => OrderCubit()
                  ..getMyTasks())),
        BlocProvider(create: ((context) => DetailsCubit())),
        BlocProvider(create: ((context) => LanguageCubit())),
        BlocProvider(
            create: ((context) =>
                AddressCubit()..getMyAddresses(afterSuccess: () {}))),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LocalizedApp(
                delegate,
                MaterialApp(
                  title: 'JetCare',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    delegate,
                  ],
                  locale: delegate.currentLocale,
                  supportedLocales: delegate.supportedLocales,
                  onGenerateRoute: widget.appRouter.onGenerateRoute,
                  initialRoute: AppRouterNames.splash,
                  theme: ThemeData(
                    colorSchemeSeed: const Color(0xFF0D9D7D),
                    useMaterial3: true,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
