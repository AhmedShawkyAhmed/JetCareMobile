import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/main.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/network_base_model.dart';
import 'package:jetcare/src/core/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/data/requests/fcm_request.dart';
import 'package:jetcare/src/features/auth/data/requests/login_request.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/profile/data/models/user_model.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';

part 'authenticate_state.dart';

class AuthenticateCubit extends Cubit<AuthenticateState> {
  AuthenticateCubit(this.networkService) : super(AuthenticateInitial());
  NetworkService networkService;

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
    try {
      await networkService
          .post(
        url: EndPoints.login,
        body: LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      )
          .then((value) async {
        NetworkBaseModel<UserModel> response =
            NetworkBaseModel.fromJson(value.data);
        await updateFCM(id: response.data!.id!);
        await ProfileCubit(instance()).getProfile();
      });
    } on DioException catch (n) {
      printError(n.toString());
      emit(AuthenticateFailure());
    } catch (e) {
      printError(e);
      emit(AuthenticateFailure());
    }
  }

  Future updateFCM({
    required int id,
  }) async {
    try {
      emit(FCMLoadingState());
      await networkService
          .post(
        url: EndPoints.updateFCM,
        body: FCMRequest(
          id: id,
          fcm: fcmToken!,
        ),
      )
          .then((value) {
        NetworkBaseModel response = NetworkBaseModel.fromJson(value.data);
        printSuccess("FCM Response ${response.status}");
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
}
