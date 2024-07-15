import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/caching/database_helper.dart';
import 'package:jetcare/src/core/caching/database_keys.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Future changeLanguage() async {
    if (isArabic) {
      await toEnglish();
    } else {
      await toArabic();
    }
    NavigationService.pushNamedAndRemoveUntil(Routes.splash, (route) => false);
  }

  Future toArabic() async {
    await DatabaseHelper.putItem(
      boxName: DatabaseBox.appBox,
      key: DatabaseKey.language,
      item: Languages.ar.name,
    );
    await delegate.changeLocale(Locale(Languages.ar.name));
    emit(LanguageChangeState());
  }

  Future toEnglish() async {
    await DatabaseHelper.putItem(
      boxName: DatabaseBox.appBox,
      key: DatabaseKey.language,
      item: Languages.en.name,
    );
    await delegate.changeLocale(Locale(Languages.en.name));
    emit(LanguageChangeState());
  }
}
