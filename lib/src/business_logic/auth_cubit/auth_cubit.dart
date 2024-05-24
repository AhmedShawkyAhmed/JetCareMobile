import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/requests/account_request.dart';
import 'package:jetcare/src/data/network/responses/auth_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.networkService) : super(AuthInitial());
  NetworkService networkService;
  AuthResponse? authResponse, updateAccountResponse, registerResponse;
  GlobalResponse? globalResponse,
      checkPhoneResponse,
      resetPasswordResponse,
      fcmResponse,
      sendEmailResponse;
  bool pass = true;
  String verify = "";
  num randomNumber = Random().nextInt(999999) + 100000;

  void isPassword() {
    pass = !pass;
    emit(ChangePasswordState());
  }

  Future updateFCM({
    required int id,
    required String fcm,
  }) async {
    try {
      emit(FCMLoadingState());
      await networkService.post(
        url: EndPoints.updateFCM,
        body: {
          'id': id,
          'fcm': fcm,
        },
      ).then((value) {
        fcmResponse = GlobalResponse.fromJson(value.data);
        printSuccess("FCM Response ${fcmResponse!.status.toString()}");
        emit(FCMSuccessState());
      });
    } on DioException catch (n) {
      emit(FCMErrorState());
      printError(n.toString());
    } catch (e) {
      emit(FCMErrorState());
      printError(e.toString());
    }
  }

  Future resetPassword({
    required LoginRequest authRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ResetPasswordLoadingState());
      await networkService.post(
        url: EndPoints.resetPassword,
        body: {
          'phone': authRequest.email,
          'password': authRequest.password,
        },
      ).then((value) {
        resetPasswordResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Reset Password Response ${resetPasswordResponse!.status.toString()}");
        emit(ResetPasswordSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(ResetPasswordErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ResetPasswordErrorState());
      printError(e.toString());
    }
  }

  Future checkEmail({
    required String email,
    required VoidCallback found,
    required VoidCallback notFound,
  }) async {
    try {
      emit(CheckEmailLoadingState());
      await networkService.post(
        url: EndPoints.checkEmail,
        body: {
          'email': email,
        },
      ).then((value) {
        printResponse(value.data.toString());
        checkPhoneResponse = GlobalResponse.fromJson(value.data);
        verifyCode = randomNumber.toInt();
        printSuccess(
            "Check Phone Response ${checkPhoneResponse!.status.toString()}");
        if (checkPhoneResponse!.status.toString() == "200") {
          notFound();
        } else {
          found();
        }
        emit(CheckEmailSuccessState());
      });
    } on DioException catch (n) {
      emit(CheckEmailErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CheckEmailErrorState());
      printError(e.toString());
    }
  }

  Future register({
    required AccountRequest accountRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(RegisterLoadingState());
      await networkService.post(
        url: EndPoints.register,
        body: {
          'name': accountRequest.name,
          'phone': accountRequest.phone,
          'email': accountRequest.email,
          'role': accountRequest.role,
          'password': accountRequest.password,
        },
      ).then((value) {
        registerResponse = AuthResponse.fromJson(value.data);
        globalAccountModel = registerResponse!.accountModel!;
        CacheService.add(
            key: CacheKeys.phone, value: accountRequest.email.toString());
        CacheService.add(
            key: CacheKeys.password, value: accountRequest.password.toString());
        printSuccess(
            "Register Response ${registerResponse!.status.toString()}");
        emit(RegisterSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(RegisterErrorState());
      printError(n.toString());
    } catch (e) {
      emit(RegisterErrorState());
      printError(e.toString());
    }
  }

  Future updateAccount({
    required AccountRequest accountRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateLoadingState());
      await networkService.post(
        url: EndPoints.updateAccount,
        body: {
          'id': globalAccountModel.id,
          'name': accountRequest.name ?? '',
          'phone': accountRequest.phone ?? '',
          'email': accountRequest.email ?? '',
        },
      ).then((value) {
        updateAccountResponse = AuthResponse.fromJson(value.data);
        globalAccountModel = updateAccountResponse!.accountModel!;
        CacheService.add(
            key: CacheKeys.phone,
            value: updateAccountResponse!.accountModel!.phone.toString());
        printSuccess(
            "Update Account Response ${updateAccountResponse!.status.toString()}");
        emit(UpdateSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(UpdateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateErrorState());
      printError(e.toString());
    }
  }

  Future deleteAccount({
    required String userId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteLoadingState());
      await networkService.post(
        url: EndPoints.deleteAccount,
        body: {
          'id': userId,
        },
      ).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Delete Account Response ${globalResponse!.status.toString()}");
        emit(DeleteSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(DeleteErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteErrorState());
      printError(e.toString());
    }
  }

  Future sendEmail({
    required String email,
    required VoidCallback success,
    required VoidCallback failed,
  }) async {
    try {
      emit(SendEmailLoadingState());
      await networkService.post(
        url: EndPoints.mail,
        body: {
          'email': email,
          'code': verifyCode,
        },
      ).then((value) {
        printSuccess(verifyCode.toString());
        sendEmailResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Send Email Response ${sendEmailResponse!.status.toString()}");
        if (sendEmailResponse!.status.toString() == "200") {
          success();
        } else {
          failed();
        }
        emit(SendEmailSuccessState());
      });
    } on DioException catch (n) {
      emit(SendEmailErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SendEmailErrorState());
      printError(e.toString());
    }
  }
}
