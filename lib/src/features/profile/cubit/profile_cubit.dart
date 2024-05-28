import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/profile/data/repo/profile_repo.dart';
import 'package:jetcare/src/features/profile/data/requests/update_profile_request.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:sizer/sizer.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo) : super(ProfileInitial());
  ProfileRepo repo;

  bool update = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void initProfile() {
    update = false;
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  Future updateProfile() async {
    if (nameController.text == "" &&
        phoneController.text == "" &&
        emailController.text == "") {
      DefaultToast.showMyToast(translate(AppStrings.updateProfile));
      return;
    }
    IndicatorView.showIndicator();
    emit(UpdateProfileLoading());
    var response = await repo.updateProfile(
      request: UpdateProfileRequest(
        name: nameController.text.isEmpty
            ? Globals.userData.name
            : nameController.text,
        email: emailController.text.isEmpty
            ? Globals.userData.email
            : emailController.text,
        phone: phoneController.text.isEmpty
            ? Globals.userData.phone
            : phoneController.text,
      ),
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (nameController.text.isNotEmpty) {
          Globals.userData.name = nameController.text;
        }
        if (emailController.text.isNotEmpty) {
          Globals.userData.email = emailController.text;
        }
        if (phoneController.text.isNotEmpty) {
          Globals.userData.name = phoneController.text;
        }
        DefaultToast.showMyToast(translate(AppStrings.saveData));
        NavigationService.pop();
        update = false;
        emit(UpdateProfileSuccess());
        nameController.clear();
        phoneController.clear();
        emailController.clear();
      },
      failure: (NetworkExceptions error) {
        error.showError();
        NavigationService.pop();
        emit(UpdateProfileFailure());
      },
    );
  }

  Future getProfile({
    bool isNewAccount = false,
  }) async {
    emit(ProfileLoading());
    var response = await repo.profile();
    response.when(
      success: (NetworkBaseModel response) async {
        Globals.userData = response.data!;
        printSuccess(Globals.userData.role);
        if (Globals.userData.isActive == false) {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.disable,
            (route) => false,
          );
        } else if (Globals.userData.isArchived == true) {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.deleted,
            (route) => false,
          );
        } else {
          if (Globals.userData.role == Roles.client.name) {
            if(isNewAccount){
              NavigationService.pushReplacementNamed(Routes.welcome);
            }else{
              NavigationService.pushReplacementNamed(Routes.layout);
            }
          } else {
            NavigationService.pushReplacementNamed(Routes.crewLayout);
          }
        }
        emit(ProfileSuccess());
      },
      failure: (NetworkExceptions error) {
        CacheService.clear();
        NavigationService.pushReplacementNamed(Routes.login);
        error.showError();
        emit(ProfileFailure());
      },
    );
  }

  void deleteAccountDialog() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.mainColor,
          title: DefaultText(
            text: translate(AppStrings.deleteAccount),
            align: TextAlign.center,
            fontSize: 19.sp,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultText(
                  text: translate(AppStrings.deleteAlert),
                  align: TextAlign.center,
                  fontSize: 15.sp,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultText(
              text: translate(AppStrings.deleteAccount),
              align: TextAlign.center,
              fontSize: 13.sp,
              textColor: AppColors.darkRed,
              onTap: () {
                deleteAccount();
              },
            ),
            DefaultText(
              text: translate(AppStrings.cancel),
              align: TextAlign.center,
              fontSize: 13.sp,
              onTap: () {
                NavigationService.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future deleteAccount() async {
    IndicatorView.showIndicator();
    emit(DeleteAccountLoading());
    var response = await repo.deleteAccount();
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.splash,
          (route) => false,
        );
        emit(DeleteAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        NavigationService.pop();
        emit(DeleteAccountFailure());
      },
    );
  }

  Future restoreAccount() async {
    IndicatorView.showIndicator();
    emit(RestoreAccountLoading());
    var response = await repo.restoreAccount();
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.splash,
          (route) => false,
        );
        emit(RestoreAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        NavigationService.pop();
        emit(RestoreAccountFailure());
      },
    );
  }
}
