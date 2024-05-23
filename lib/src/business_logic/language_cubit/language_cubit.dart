import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  void toArabic({
    VoidCallback? afterSuccess,
  }) {
    CacheService.add(key: CacheKeys.language, value: Languages.ar.name);
    delegate.changeLocale(Locale(Languages.ar.name));
    emit(LanguageChangeState());
    afterSuccess!();
  }

  void toEnglish({
    VoidCallback? afterSuccess,
  }) {
    CacheService.add(key: CacheKeys.language, value: Languages.en.name);
    delegate.changeLocale(Locale(Languages.en.name));
    emit(LanguageChangeState());
    afterSuccess!();
  }
}
