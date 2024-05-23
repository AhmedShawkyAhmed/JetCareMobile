import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/routing/app_router.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:sizer/sizer.dart';

import 'app_builder.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutes routes = AppRoutes();

  @override
  Future<void> initState() async {
    final locale =
        CacheService.get(key: CacheKeys.language) ?? Languages.ar.name;
    CacheService.add(key: CacheKeys.language, value: locale);
    delegate = await LocalizationDelegate.create(
      fallbackLocale: locale,
      supportedLocales: [Languages.ar.name, Languages.en.name],
    );
    await delegate.changeLocale(Locale(locale));
    if (CacheService.get(key: CacheKeys.language) == null) {
      CacheService.add(key: CacheKeys.language, value: Languages.ar.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return LocalizedApp(
          delegate,
          MaterialApp(
            builder: defaultAppBuilder,
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              delegate,
            ],
            supportedLocales: delegate.supportedLocales,
            locale: delegate.currentLocale,
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: routes.onGenerateRoute,
            initialRoute: '/',
            theme: ThemeData(
              colorSchemeSeed: const Color(0xFF0D9D7D),
              useMaterial3: true,
            ),
            title: 'JetCare',
          ),
        );
      },
    );
  }
}
