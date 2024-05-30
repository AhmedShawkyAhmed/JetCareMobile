import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/network/end_points.dart';
import 'package:jetcare/src/core/network/network_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/data/network/requests/corporate_request.dart';
import 'package:jetcare/src/data/network/requests/order_request.dart';
import 'package:jetcare/src/data/network/responses/corporate_response.dart';
// import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/history_response.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.networkService) : super(OrderInitial());

  NetworkService networkService;

  CorporateResponse? corporateResponse;

  // GlobalResponse? globalResponse, orderResponse;
  HistoryResponse? historyResponse;

  Future getMyOrders() async {
    try {
      emit(MyOrdersLoadingState());
      await networkService.get(url: EndPoints.getMyOrders, query: {
        'userId': Globals.userData.id,
      }).then((value) {
        historyResponse = HistoryResponse.fromJson(value.data);
        printSuccess(
            "My Orders Response ${historyResponse!.status.toString()}");
        emit(MyOrdersSuccessState());
      });
    } on DioException catch (n) {
      emit(MyOrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(MyOrdersErrorState());
      printError(e.toString());
    }
  }

  Future corporateOrder({
    required CorporateRequest corporateRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CorporateLoadingState());
      await networkService.post(url: EndPoints.addCorporateOrder, body: {
        'userId': corporateRequest.userId,
        'name': corporateRequest.name,
        'email': corporateRequest.email,
        'phone': corporateRequest.phone,
        'message': corporateRequest.message,
        'itemId': corporateRequest.itemId,
      }).then((value) {
        corporateResponse = CorporateResponse.fromJson(value.data);
        printSuccess(
            "Corporate Response ${corporateResponse!.status.toString()}");
        emit(CorporateSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(CorporateErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CorporateErrorState());
      printError(e.toString());
    }
  }

  Future createOrder({
    required OrderRequest orderRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(OrdersLoadingState());
      await networkService.post(
        url: EndPoints.createOrder,
        body: {
          'userId': Globals.userData.id,
          'periodId': orderRequest.periodId,
          'addressId': orderRequest.addressId,
          'date': orderRequest.date,
          'price': orderRequest.price,
          'relationId': orderRequest.relationId,
          'shipping': orderRequest.shipping,
          'total': orderRequest.total,
          'comment': orderRequest.comment,
          'cart': orderRequest.cart.isEmpty ? "" : orderRequest.cart,
        },
      ).then((value) {
        printResponse(value.data.toString());
        // orderResponse = GlobalResponse.fromJson(value.data);
        emit(OrdersSuccessState());
        afterSuccess();
        // printSuccess("Order Response ${orderResponse!.message.toString()}");
      });
    } on DioException catch (n) {
      emit(OrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(OrdersErrorState());
      printError(e.toString());
    }
  }

  Future updateOrderStatusUser({
    required int orderId,
    required String status,
    String? reason,
    required VoidCallback afterSuccess,
    required VoidCallback afterCancel,
  }) async {
    try {
      emit(UpdateOrderStatusLoadingState());
      await networkService.post(url: EndPoints.updateOrderStatusUser, body: {
        'id': orderId,
        'status': status,
        'reason': reason,
      }).then((value) {
        // globalResponse = GlobalResponse.fromJson(value.data);
        // printSuccess(
            // "Order Status Response ${globalResponse!.message.toString()}");
        emit(UpdateOrderStatusSuccessState());
        // if (globalResponse!.status == 200) {
        //   afterSuccess();
        // } else if (globalResponse!.status == 402) {
        //   DefaultToast.showMyToast(globalResponse!.message.toString());
        //   afterCancel();
        // }
      });
    } on DioException catch (n) {
      emit(UpdateOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateOrderStatusErrorState());
      printError(e.toString());
    }
  }

  Future deleteOrder({
    required int orderId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteOrderStatusLoadingState());
      await networkService.post(url: EndPoints.deleteOrder, body: {
        'id': orderId,
      }).then((value) {
        // globalResponse = GlobalResponse.fromJson(value.data);
        // printSuccess(
        //     "Delete Order Response ${globalResponse!.message.toString()}");
        emit(DeleteOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioException catch (n) {
      emit(DeleteOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteOrderStatusErrorState());
      printError(e.toString());
    }
  }
}
