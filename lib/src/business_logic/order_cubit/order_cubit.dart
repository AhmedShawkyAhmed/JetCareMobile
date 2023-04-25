import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetcare/src/data/network/requests/corporate_request.dart';
import 'package:jetcare/src/data/network/requests/order_request.dart';
import 'package:jetcare/src/data/network/responses/corporate_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';
import 'package:jetcare/src/data/network/responses/history_response.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  CorporateResponse? corporateResponse;

  GlobalResponse? globalResponse, orderResponse;
  HistoryResponse? historyResponse, tasksResponse;

  Future getMyTasks() async {
    try {
      emit(MyTasksLoadingState());
      await DioHelper.getData(url: EndPoints.getMyTasks, query: {
        'crewId': globalAccountModel.id,
      }).then((value) {
        tasksResponse = HistoryResponse.fromJson(value.data);
        printSuccess("My Tasks Response ${tasksResponse!.message.toString()}");
        emit(MyTasksSuccessState());
      });
    } on DioError catch (n) {
      emit(MyTasksErrorState());
      printError(n.toString());
    } catch (e) {
      emit(MyTasksErrorState());
      printError(e.toString());
    }
  }

  Future getMyOrders() async {
    try {
      emit(MyOrdersLoadingState());
      await DioHelper.getData(url: EndPoints.getMyOrders, query: {
        'userId': globalAccountModel.id,
      }).then((value) {
        historyResponse = HistoryResponse.fromJson(value.data);
        printSuccess(
            "My Orders Response ${historyResponse!.status.toString()}");
        emit(MyOrdersSuccessState());
      });
    } on DioError catch (n) {
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
      await DioHelper.postData(url: EndPoints.addCorporateOrder, body: {
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
    } on DioError catch (n) {
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
    printError(orderRequest.extraIds.length.toString());
    try {
      emit(OrdersLoadingState());
      await DioHelper.postData(
        url: EndPoints.createOrder,
        body: {
          'userId': orderRequest.userId,
          'packageId': orderRequest.packageId,
          'calendarId': orderRequest.calendarId,
          'spaceId': orderRequest.spaceId,
          'periodId': orderRequest.periodId,
          'total': orderRequest.total,
          'addressId': orderRequest.addressId,
          'date': orderRequest.date,
          'itemId': orderRequest.itemId,
          'comment': orderRequest.comment,
          'extras': orderRequest.extraIds.isEmpty ? "" : orderRequest.extraIds,
        },
        formData: false,
      ).then((value) {
        printResponse(value.data.toString());
        orderResponse = GlobalResponse.fromJson(value.data);
        printSuccess("Order Response ${orderResponse!.message.toString()}");
        emit(OrdersSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(OrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(OrdersErrorState());
      printError(e.toString());
    }
  }

  Future rejectOrder({
    required int orderId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(RejectOrderLoadingState());
      await DioHelper.postData(url: EndPoints.rejectOrder, body: {
        'id': orderId,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Order Reject Response ${globalResponse!.message.toString()}");
        emit(RejectOrderSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(RejectOrderErrorState());
      printError(n.toString());
    } catch (e) {
      emit(RejectOrderErrorState());
      printError(e.toString());
    }
  }

  Future updateOrderStatus({
    required int orderId,
    required String status,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateOrderStatusLoadingState());
      await DioHelper.postData(url: EndPoints.updateOrderStatus, body: {
        'id': orderId,
        'status': status,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Order Status Response ${globalResponse!.message.toString()}");
        emit(UpdateOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
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
      await DioHelper.postData(url: EndPoints.deleteOrder, body: {
        'id': orderId,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        printSuccess(
            "Delete Order Response ${globalResponse!.message.toString()}");
        emit(DeleteOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteOrderStatusErrorState());
      printError(e.toString());
    }
  }
}
