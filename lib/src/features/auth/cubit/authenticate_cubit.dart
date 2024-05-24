import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/forget_password_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/auth/data/requests/mail_request.dart';
import 'package:jetcare/src/features/auth/data/requests/register_request.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';

part 'authenticate_state.dart';

class AuthenticateCubit extends Cubit<AuthenticateState> {
  AuthenticateCubit(this.repo) : super(AuthenticateInitial());
  AuthRepo repo;

  num randomNumber = Random().nextInt(999999) + 100000;
  int verifyCode = 0;
  bool password = true;
  bool singIn = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future checkEmail() async {
    emit(CheckEmailLoadingState());
    var response = await repo.checkEmail(
      request: MailRequest(
        email: emailController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        verifyCode = randomNumber.toInt();
        if (response.status == 200) {
          NavigationService.pop();
          DefaultToast.showMyToast(
            translate(AppStrings.phoneNotExist),
          );
        } else {
          sendEmail();
        }
        emit(CheckEmailSuccessState());
      },
      failure: (NetworkExceptions error) {
        emit(CheckEmailFailureState());
        error.showError();
      },
    );
  }

  Future sendEmail() async {
    emit(SendEmailLoadingState());
    var response = await repo.mail(
      request: MailRequest(
        email: emailController.text,
        code: verifyCode,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        emit(SendEmailSuccessState());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        DefaultToast.showMyToast(
          translate(AppStrings.error),
        );
        emit(SendEmailFailureState());
        error.showError();
      },
    );
  }

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
    emit(LoginLoadingState());
    var response = await repo.login(
      request: LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(LoginSuccessState());
        CacheService.add(key: CacheKeys.token, value: response.data!.token);
        if (fcmToken != null) {
          await updateFCM(id: response.data!.id!);
        }
        await ProfileCubit(instance()).getProfile();
      },
      failure: (NetworkExceptions error) {
        emit(LoginFailureState());
        error.showError();
      },
    );
  }

  Future register() async {
    if (nameController.text.isEmpty &&
        phoneController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
      DefaultToast.showMyToast(translate(AppStrings.enterData));
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      DefaultToast.showMyToast(translate(AppStrings.passwordMatched));
      return;
    }
    IndicatorView.showIndicator();
    emit(RegisterLoadingState());
    var response = await repo.register(
      request: RegisterRequest(
        name: nameController.text,
        phone: phoneController.text,
        role: Roles.client.name,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(RegisterSuccessState());
        CacheService.add(key: CacheKeys.token, value: response.data!.token);
        if (fcmToken != null) {
          await updateFCM(id: response.data!.id!);
        }
        await ProfileCubit(instance()).getProfile();
      },
      failure: (NetworkExceptions error) {
        emit(RegisterFailureState());
        error.showError();
      },
    );
  }

  Future resetPassword() async {
    if (emailController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterEmail));
      return;
    }
    if (passwordController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterPassword));
      return;
    }
    IndicatorView.showIndicator();
    emit(ResetPasswordLoadingState());
    var response = await repo.resetPassword(
      request: LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(ResetPasswordSuccessState());
        NavigationService.pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        emit(ResetPasswordFailureState());
        error.showError();
      },
    );
  }

  Future forgetPassword() async {
    if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      DefaultToast.showMyToast(translate(AppStrings.enterPassword));
      return;
    }
    if (confirmPasswordController.text == passwordController.text) {
      DefaultToast.showMyToast(translate(AppStrings.passwordMatched));
      return;
    }
    IndicatorView.showIndicator();
    emit(ResetPasswordLoadingState());
    var response = await repo.forgetPassword(
      request: ForgetPasswordRequest(
        password: passwordController.text,
        newPassword: confirmPasswordController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(ResetPasswordSuccessState());
        NavigationService.pushNamedAndRemoveUntil(
          Routes.login,
              (route) => false,
        );
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        emit(ResetPasswordFailureState());
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
        emit(FCMFailureState());
        error.showError();
      },
    );
  }

  Future logout() async {
    emit(LogoutLoadingState());
    var response = await repo.logout();
    response.when(
      success: (NetworkBaseModel response) async {
        CacheService.clear();
        NavigationService.pushNamedAndRemoveUntil(
            Routes.login, (route) => false);
        emit(LogoutSuccessState());
      },
      failure: (NetworkExceptions error) {
        DefaultToast.showMyToast(
          translate(error.message),
        );
        emit(LogoutFailureState());
        error.showError();
      },
    );
  }
}
