import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';

part 'authenticate_state.dart';

class AuthenticateCubit extends Cubit<AuthenticateState> {
  AuthenticateCubit(this.repo) : super(AuthenticateInitial());
  AuthRepo repo;

  bool password = true;
  bool singIn = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login() async {
    if (emailController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterEmail));
      return;
    }
    if (passwordController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterPassword));
      return;
    }
    IndicatorView.showIndicator();
    emit(AuthenticateLoading());
    var response = await repo.login(
      request: LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AuthenticateSuccess());
        CacheService.add(key: CacheKeys.token,value: response.data!.token);
        if (fcmToken != null) {
          await updateFCM(id: response.data!.id!);
        }
        await ProfileCubit(instance()).getProfile();
      },
      failure: (NetworkExceptions error) {
        emit(AuthenticateFailure());
        error.showError();
      },
    );
  }

  Future updateFCM({
    required int id,
  }) async {
    emit(FCMLoadingState());
    var response = await repo.fcm(
      request: FCMRequest(
        id: id,
        fcm: fcmToken!,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(FCMSuccessState());
        printSuccess("FCM Response ${response.status}");
      },
      failure: (NetworkExceptions error) {
        emit(FCMErrorState());
        error.showError();
      },
    );
  }
}
