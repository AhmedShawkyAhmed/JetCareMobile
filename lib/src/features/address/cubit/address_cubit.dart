import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/data/repo/address_repo.dart';
import 'package:jetcare/src/features/address/data/requests/address_request.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.repo) : super(AddressInitial());

  final AddressRepo repo;

  List<AddressModel> address = [];
  List<AreaModel> states = [];
  List<AreaModel> areas = [];

  Future getMyAddresses() async {
    address.clear();
    emit(GetAddressLoading());
    var response = await repo.getMyAddresses();
    response.when(
      success: (NetworkBaseModel response) async {
        address = response.data;
        emit(GetAddressSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetAddressFailure());
      },
    );
  }

  Future addAddress({
    required AddressRequest request,
  }) async {
    if (request.phone == null || request.phone == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterPhone));
      return;
    } else if (request.address == null || request.address == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterAddress));
      return;
    } else if (request.stateId == null || request.stateId == 0) {
      DefaultToast.showMyToast(translate(AppStrings.enterState));
      return;
    } else if (request.areaId == null || request.areaId == 0) {
      DefaultToast.showMyToast(translate(AppStrings.enterArea));
      return;
    }
    IndicatorView.showIndicator();
    emit(AddAddressLoading());
    var response = await repo.addAddress(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        getMyAddresses();
        NavigationService.pop();
        emit(AddAddressSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(AddAddressFailure());
      },
    );
  }

  Future updateAddress({
    required AddressRequest request,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateAddressLoading());
    var response = await repo.updateAddress(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        getMyAddresses();
        NavigationService.pop();
        emit(UpdateAddressSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(UpdateAddressFailure());
      },
    );
  }

  Future deleteAddress({
    required int id,
  }) async {
    emit(DeleteAddressLoading());
    var response = await repo.deleteAddress(id: id);
    response.when(
      success: (NetworkBaseModel response) async {
        emit(DeleteAddressSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(DeleteAddressFailure());
      },
    );
  }

  Future getStates() async {
    states.clear();
    emit(GetStatesLoading());
    var response = await repo.getStates();
    response.when(
      success: (NetworkBaseModel response) async {
        states = response.data;
        emit(GetStatesSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetStatesFailure());
      },
    );
  }

  Future getAreasOfState({
    required int stateId,
  }) async {
    areas.clear();
    emit(GetAreasLoading());
    var response = await repo.getAreasOfState(stateId: stateId);
    response.when(
      success: (NetworkBaseModel response) async {
        areas = response.data;
        emit(GetAreasSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetAreasFailure());
      },
    );
  }
}
