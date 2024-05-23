import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/services/cache_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  void toArabic({
    VoidCallback? afterSuccess,
  }) {
    CacheService.add(key: 'language', value: "ar");
    delegate.changeLocale(const Locale("ar"));
    emit(LanguageChangeState());
    afterSuccess!();
  }

  void toEnglish({
    VoidCallback? afterSuccess,
  }) {
    CacheService.add(key: 'language', value: "en");
    delegate.changeLocale(const Locale("en"));
    emit(LanguageChangeState());
    afterSuccess!();
  }
}
