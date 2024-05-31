import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/corporate/data/models/corporate_model.dart';
import 'package:jetcare/src/features/corporate/data/repo/corporate_repo.dart';
import 'package:jetcare/src/features/corporate/data/requests/corporate_request.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';

part 'corporate_state.dart';

class CorporateCubit extends Cubit<CorporateState> {
  CorporateCubit(this.repo) : super(CorporateInitial());

  final CorporateRepo repo;

  List<CorporateModel> corporates = [];

  Future getMyCorporateOrders() async {
    corporates.clear();
    emit(GetCorporateOrdersLoading());
    var response = await repo.getMyCorporateOrders();
    response.when(
      success: (NetworkBaseModel response) async {
        corporates = response.data ?? [];
        emit(GetCorporateOrdersSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetCorporateOrdersFailure());
      },
    );
  }

  Future addCorporateOrder({
    required CorporateRequest request,
  }) async {
    if (request.name == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterName));
      return;
    } else if (request.email == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterEmail));
      return;
    } else if (request.phone == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterPhone));
      return;
    } else if (request.message == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterMessage));
      return;
    }
    IndicatorView.showIndicator();
    emit(AddCorporateLoading());
    var response = await repo.addCorporateOrder(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        emit(AddCorporateSuccess());
        await Future.delayed(const Duration(milliseconds: 100), () {
          NavigationService.pushNamedAndRemoveUntil(
            Routes.success,
            arguments: SuccessType.order,
            (route) => false,
          );
        });
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(AddCorporateFailure());
      },
    );
  }
}
