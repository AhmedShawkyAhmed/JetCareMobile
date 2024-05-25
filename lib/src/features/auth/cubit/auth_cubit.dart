import 'dart:async';

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
import 'package:jetcare/src/core/routing/arguments/otp_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/password_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/register_arguments.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/data/repo/auth_repo.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/forget_password_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/auth/data/requests/mail_request.dart';
import 'package:jetcare/src/features/auth/data/requests/register_request.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthenticateInitial());
  AuthRepo repo;

  bool password = true;
  bool singIn = true;
  bool confirm = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future checkEmail({
    required OTPTypes type,
  }) async {
    emit(CheckEmailLoadingState());
    IndicatorView.showIndicator();
    var response = await repo.checkEmail(
      request: MailRequest(
        email: emailController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (type == OTPTypes.register) {
          if (response.status == 200) {
            verifyEmail(type: type);
          } else {
            NavigationService.pop();
            DefaultToast.showMyToast(
              translate(AppStrings.phoneNotExist),
            );
          }
        } else {
          if (response.status == 202) {
            verifyEmail(type: type);
          } else {
            NavigationService.pop();
            DefaultToast.showMyToast(
              translate(AppStrings.phoneNotExist),
            );
          }
        }
        emit(CheckEmailSuccessState());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        emit(CheckEmailFailureState());
        error.showError();
      },
    );
  }

  Future verifyEmail({
    required OTPTypes type,
    String? email,
  }) async {
    emit(VerifyEmailLoadingState());
    if (type == OTPTypes.resend) {
      IndicatorView.showIndicator();
    }
    var response = await repo.verifyEmail(
      request: MailRequest(
        email: email ?? emailController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (type == OTPTypes.resend) {
          NavigationService.pop();
          DefaultToast.showMyToast(translate(AppStrings.codeReSent));
        } else {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.otp,
            (route) => false,
            arguments: OtpArguments(
              email: emailController.text,
              type: type,
            ),
          );
        }
        emit(VerifyEmailSuccessState());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        DefaultToast.showMyToast(
          translate(AppStrings.error),
        );
        emit(VerifyEmailFailureState());
        error.showError();
      },
    );
  }

  Future validateCode({
    required OTPTypes type,
    required String email,
    required String code,
  }) async {
    if (code.isEmpty) {
      DefaultToast.showMyToast(translate(AppStrings.enterCode));
      return;
    }
    IndicatorView.showIndicator();
    emit(ValidateCodeLoadingState());
    var response = await repo.validateCode(
      request: MailRequest(
        email: email,
        code: int.parse(code),
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (type == OTPTypes.resetPassword) {
          NavigationService.pushNamed(
            Routes.resetPassword,
            arguments: PasswordArguments(
              email: email,
            ),
          );
        } else {
          NavigationService.pushNamed(
            Routes.register,
            arguments: RegisterArguments(
              email: email,
            ),
          );
        }
        emit(ValidateCodeSuccessState());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        DefaultToast.showMyToast(translate(AppStrings.wrongCode));
        emit(ValidateCodeFailureState());
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

  Future register({
    required RegisterRequest request,
  }) async {
    printError(request);
    if (request.name.isEmpty &&
        request.phone.isEmpty &&
        request.password.isEmpty &&
        request.confirmPassword!.isEmpty) {
      DefaultToast.showMyToast(translate(AppStrings.enterData));
      return;
    } else if (request.password != request.confirmPassword) {
      DefaultToast.showMyToast(translate(AppStrings.passwordMatched));
      return;
    }
    IndicatorView.showIndicator();
    emit(RegisterLoadingState());
    var response = await repo.register(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(RegisterSuccessState());
        CacheService.add(key: CacheKeys.token, value: response.data!.token);
        if (fcmToken != null) {
          await updateFCM(id: response.data!.id!);
        }
        await ProfileCubit(instance()).getProfile(isNewAccount: true);
      },
      failure: (NetworkExceptions error) {
        emit(RegisterFailureState());
        error.showError();
      },
    );
  }

  Future resetPassword({
    required String email,
  }) async {
    if (email == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterEmail));
      return;
    }
    if (passwordController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterPassword));
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      DefaultToast.showMyToast(translate(AppStrings.passwordMatched));
      return;
    }
    IndicatorView.showIndicator();
    emit(ResetPasswordLoadingState());
    var response = await repo.resetPassword(
      request: LoginRequest(
        email: email,
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
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
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
        Globals.userData = UserModel();
        CacheService.add(key: CacheKeys.language, value: Languages.ar.name);
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
