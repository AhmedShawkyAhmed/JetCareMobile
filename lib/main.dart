import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/application/app.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/services/bloc_observer.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/notification_service.dart';
import 'package:jetcare/src/presentation/screens/shared/error_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

late LocalizationDelegate delegate;
late PackageInfo packageInfo;
String? fcmToken;

void main() async {
  customError();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  await CacheService.init();
  Bloc.observer = MyBlocObserver();
  packageInfo = await PackageInfo.fromPlatform();
  await initAppModule();
  runApp(MyApp());
}
