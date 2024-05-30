import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';
import 'package:jetcare/src/features/support/data/models/info_model.dart';
import 'package:jetcare/src/features/support/data/repo/support_repo.dart';
import 'package:jetcare/src/features/support/data/requests/support_request.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit(this.repo) : super(SupportInitial());

  final SupportRepo repo;

  InfoModel? terms, about, contacts;

  Future getTerms() async {
    emit(GetInfoLoading());
    var response = await repo.getTerms();
    response.when(
      success: (NetworkBaseModel response) async {
        terms = response.data;
        emit(GetInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetInfoFailure());
      },
    );
  }

  Future getAbout() async {
    emit(GetInfoLoading());
    var response = await repo.getAbout();
    response.when(
      success: (NetworkBaseModel response) async {
        about = response.data;
        emit(GetInfoSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetInfoFailure());
      },
    );
  }

  Future getContact() async {
    emit(GetContactsLoading());
    var response = await repo.getContact();
    response.when(
      success: (NetworkBaseModel response) async {
        contacts = response.data;
        emit(GetContactsSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetContactsFailure());
      },
    );
  }

  Future addSupport({
    required SupportRequest request,
  }) async {
    if (request.name == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterName));
      return;
    }
    if (request.contact == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterContact));
      return;
    }
    if (request.subject == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterSubject));
      return;
    }
    if (request.message == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterMessage));
      return;
    }
    emit(AddSupportLoading());
    var response = await repo.addSupport(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushReplacementNamed(
          Routes.success,
          arguments: SuccessType.support,
        );
        emit(AddSupportSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(AddSupportFailure());
      },
    );
  }
}
