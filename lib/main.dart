import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/application/app.dart';
import 'package:jetcare/src/core/caching/database_helper.dart';
import 'package:jetcare/src/core/caching/database_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/services/bloc_observer.dart';
import 'package:jetcare/src/core/services/notification_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/shared/screens/error_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

late LocalizationDelegate delegate;
late PackageInfo packageInfo;

void main() async {
  customError();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.init();
  await Firebase.initializeApp();
  await NotificationService.init();
  Bloc.observer = MyBlocObserver();
  packageInfo = await PackageInfo.fromPlatform();
  String? lang = await DatabaseHelper.getItem(
    boxName: DatabaseBox.appBox,
    key: DatabaseKey.language,
  );
  final locale = lang ?? Languages.ar.name;
  DatabaseHelper.putItem(
    boxName: DatabaseBox.appBox,
    key: DatabaseKey.language,
    item: locale,
  );
  delegate = await LocalizationDelegate.create(
    fallbackLocale: locale,
    supportedLocales: [Languages.ar.name, Languages.en.name],
  );
  await delegate.changeLocale(Locale(locale));
  if (lang == null) {
    DatabaseHelper.putItem(
      boxName: DatabaseBox.appBox,
      key: DatabaseKey.language,
      item: locale,
    );
  }
  await initAppModule();

  runApp(
    LocalizedApp(
      delegate,
      MyApp(),
    ),
  );
}
