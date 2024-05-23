import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/network/api_consumer.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/models/address_model.dart';
import 'package:jetcare/src/data/models/area_model.dart';
import 'package:jetcare/src/data/network/requests/address_request.dart';
import 'package:jetcare/src/data/network/responses/address_response.dart';
import 'package:jetcare/src/data/network/responses/area_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/state_response.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.networkService) : super(AddressInitial());
  ApiConsumer networkService;
  AreaResponse? getAreaResponse;
  StatesResponse? allStatesResponse;
  AddressResponse? addressResponse, addAddressResponse;
  GlobalResponse? globalResponse, deleteResponse;
  List<AddressModel> addressList = [];
  List<String> statesList = [];
  int addressCount = 0;
  List<String> areas = [];
  List<AreaModel> areaList = [];
  List<int> areaId = [];

  Future getAllStates(
      {String? keyword, required VoidCallback afterSuccess}) async {
    try {
      emit(GetStatesLoading());
      await networkService.get(
        url: EndPoints.getAllStates,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        allStatesResponse = StatesResponse.fromJson(value.data);
        for (int i = 0; i < allStatesResponse!.statesList!.length; i++) {
          statesList.add(allStatesResponse!.statesList![i].nameAr!);
        }
        emit(GetStatesSuccess());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(GetStatesError());
      printError(n.toString());
    } catch (e) {
      emit(GetStatesError());
      printError(e.toString());
    }
  }

  Future getAllAreas({int? stateId}) async {
    try {
      emit(AreaLodingState());
      await networkService.get(
        url: EndPoints.getAreasOfState,
        query: {
          "stateId": stateId,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getAreaResponse = AreaResponse.fromJson(value.data);
        areaList.addAll(getAreaResponse!.areas!);
        for (int i = 0; i < areaList.length; i++) {
          areas.add(areaList[i].nameAr!);
          areaId.add(areaList[i].id!);
        }
        emit(AreaSuccessState());
      });
    } on DioException catch (n) {
      emit(AreaErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AreaErrorState());
      printError(e.toString());
    }
  }

  Future getMyAddresses({required VoidCallback afterSuccess}) async {
    addressList.clear();
    try {
      emit(AddressLoadingState());
      await networkService.get(url: EndPoints.getMyAddresses, query: {
        "userId": globalAccountModel.id,
      }).then((value) {
        addressResponse = AddressResponse.fromJson(value.data);
        printSuccess("Address Response ${addressResponse!.message.toString()}");
        if (addressResponse!.status.toString() == "200") {
          addressList.addAll(addressResponse!.address!);
          addressCount = addressResponse!.address!.length;
        }
        emit(AddressSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(AddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddressErrorState());
      printError(e.toString());
    }
  }

  Future addAddress({
    required AddressRequest addressRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddAddressLoadingState());
      await networkService.post(url: EndPoints.addAddress, body: {
        'userId': addressRequest.userId,
        'phone': addressRequest.phone,
        'address': addressRequest.address,
        'stateId': addressRequest.stateId,
        'areaId': addressRequest.areaId,
        'latitude': addressRequest.latitude,
        'longitude': addressRequest.longitude,
      }).then((value) {
        addAddressResponse = AddressResponse.fromJson(value.data);
        printSuccess(
            "Add Address Response ${addAddressResponse!.message.toString()}");
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(AddAddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddAddressErrorState());
      printError(e.toString());
    }
  }

  Future updateAddress({
    required AddressRequest addressRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(EditAddressLoadingState());
      await networkService.post(url: EndPoints.updateAddress, body: {
        'id': addressRequest.userId,
        'phone': addressRequest.phone,
        'address': addressRequest.address,
        'stateId': addressRequest.stateId,
        'areaId': addressRequest.areaId,
        'latitude': addressRequest.latitude,
        'longitude': addressRequest.longitude,
      }).then((value) {
        addAddressResponse = AddressResponse.fromJson(value.data);
        printSuccess(
            "Edit Address Response ${addAddressResponse!.message.toString()}");
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(EditAddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(EditAddressErrorState());
      printError(e.toString());
    }
  }

  Future deleteAddress({
    required AddressModel address,
  }) async {
    try {
      emit(DeleteAddressLoadingState());
      await networkService.post(url: EndPoints.deleteAddress, body: {
        'id': address.id,
      }).then((value) {
        printResponse(value.data.toString());
        deleteResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Delete Address Response ${deleteResponse!.message.toString()}");
        addressList.remove(address);
        addressCount -= 1;
        emit(DeleteAddressSuccessState());
      });
    } on DioException catch (n) {
      emit(DeleteAddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteAddressErrorState());
      printError(e.toString());
    }
  }
}
