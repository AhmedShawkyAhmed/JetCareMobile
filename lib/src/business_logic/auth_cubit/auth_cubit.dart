import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/network/requests/account_request.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'dart:math';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/network/requests/auth_request.dart';
import '../../data/network/responses/auth_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
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

  Future login({
    required AuthRequest authRequest,
    required VoidCallback client,
    required VoidCallback crew,
    required VoidCallback disable,
    required VoidCallback afterFail,
  }) async {
    try {
      emit(LoginLoadingState());
      await DioHelper.postData(
        url: EndPoints.login,
        body: {
          'email': authRequest.phone,
          'password': authRequest.password,
        },
      ).then((value) {
        printResponse(value.data.toString());
        if (value.data['status'].toString() != "200") {
          afterFail();
          DefaultToast.showMyToast(value.data['message'].toString());
        } else {
          authResponse = AuthResponse.fromJson(value.data);
          globalAccountModel = authResponse!.accountModel!;
          CacheHelper.saveDataSharedPreference(
              key: SharedPreferenceKeys.phone,
              value: authRequest.phone.toString());
          CacheHelper.saveDataSharedPreference(
              key: SharedPreferenceKeys.password,
              value: authRequest.password.toString());
          printSuccess("Auth Response ${authResponse!.status.toString()}");
          emit(LoginSuccessState());
          if (authResponse!.accountModel!.active != 1) {
            disable();
          } else {
            CacheHelper.saveDataSharedPreference(
                key: SharedPreferenceKeys.role,
                value: authResponse!.accountModel!.role);
            if (authResponse!.accountModel!.role == "client") {
              client();
            } else {
              crew();
            }
          }
          if (CacheHelper.getDataFromSharedPreference(
              key: SharedPreferenceKeys.fcm) ==
              null) {
            CacheHelper.saveDataSharedPreference(
                key: SharedPreferenceKeys.fcm, value: fcmToken);
          } else if (CacheHelper.getDataFromSharedPreference(
              key: SharedPreferenceKeys.fcm) !=
              globalAccountModel.fcm) {
            updateFCM(
              id: globalAccountModel.id!,
              fcm: fcmToken!,
            );
          }
        }
      });
    } on DioError catch (n) {
      emit(LoginErrorState());
      printError(n.toString());
    } catch (e) {
      emit(LoginErrorState());
      printError(e.toString());
    }
  }
  Future updateFCM({
    required int id,
    required String fcm,
  }) async {
    try {
      emit(FCMLoadingState());
      await DioHelper.postData(
        url: EndPoints.updateFCM,
        body: {
          'id': id,
          'fcm': fcm,
        },
      ).then((value) {
        fcmResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "FCM Response ${fcmResponse!.status.toString()}");
        emit(FCMSuccessState());
      });
    } on DioError catch (n) {
      emit(FCMErrorState());
      printError(n.toString());
    } catch (e) {
      emit(FCMErrorState());
      printError(e.toString());
    }
  }

  Future resetPassword({
    required AuthRequest authRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ResetPasswordLoadingState());
      await DioHelper.postData(
        url: EndPoints.resetPassword,
        body: {
          'phone': authRequest.phone,
          'password': authRequest.password,
        },
      ).then((value) {
        resetPasswordResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Reset Password Response ${resetPasswordResponse!.status.toString()}");
        emit(ResetPasswordSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
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
      await DioHelper.postData(
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
    } on DioError catch (n) {
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
      await DioHelper.postData(
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
        CacheHelper.saveDataSharedPreference(
            key: SharedPreferenceKeys.phone,
            value: accountRequest.email.toString());
        CacheHelper.saveDataSharedPreference(
            key: SharedPreferenceKeys.password,
            value: accountRequest.password.toString());
        printSuccess(
            "Register Response ${registerResponse!.status.toString()}");
        emit(RegisterSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
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
      await DioHelper.postData(
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
        CacheHelper.saveDataSharedPreference(
            key: SharedPreferenceKeys.phone,
            value: updateAccountResponse!.accountModel!.phone.toString());
        printSuccess(
            "Update Account Response ${updateAccountResponse!.status.toString()}");
        emit(UpdateSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
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
      await DioHelper.postData(
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
    } on DioError catch (n) {
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
      await DioHelper.postData(
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
    } on DioError catch (n) {
      emit(SendEmailErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SendEmailErrorState());
      printError(e.toString());
    }
  }
}
