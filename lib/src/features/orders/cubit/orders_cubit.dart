import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/notifications/cubit/notification_cubit.dart';
import 'package:jetcare/src/features/notifications/data/requests/notification_request.dart';
import 'package:jetcare/src/features/orders/data/repo/orders_repo.dart';
import 'package:jetcare/src/features/orders/data/requests/order_request.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repo) : super(OrdersInitial());
  final OrdersRepo repo;

  List<OrderModel> orders = [];

  Future getMyOrders() async {
    orders.clear();
    emit(GetMyOrdersLoading());
    var response = await repo.getMyOrders();
    response.when(
      success: (NetworkBaseModel response) async {
        orders = response.data;
        emit(GetMyOrdersSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetMyOrdersFailure());
      },
    );
  }

  Future createOrder({
    required OrderRequest request,
  }) async {
    if (request.date == "") {
      DefaultToast.showMyToast(translate(AppStrings.selectData));
      return;
    } else if (request.addressId == 0) {
      DefaultToast.showMyToast(translate(AppStrings.selectAddress));
      return;
    } else if (request.periodId == 0) {
      DefaultToast.showMyToast(translate(AppStrings.selectTime));
      return;
    }
    IndicatorView.showIndicator();
    emit(CreateOrderLoading());
    var response = await repo.createOrder(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushReplacementNamed(
          Routes.success,
          arguments: SuccessType.order,
        );
        NotificationCubit(instance()).saveNotification(
          request: NotificationRequest(
            userId: Globals.userData.id!,
            title: "الطلبات",
            message: "تم إنشاء طلبك بنجاح و بإنتظار التأكيد",
          ),
        );
        emit(CreateOrderSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(CreateOrderFailure());
      },
    );
  }

  Future cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    if (reason == "") {
      DefaultToast.showMyToast(translate(AppStrings.enterCancelReason));
    }
    IndicatorView.showIndicator();
    emit(CancelOrderLoading());
    var response = await repo.cancelOrder(
      orderId: orderId,
      reason: reason,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushReplacementNamed(
          Routes.layout,
          arguments: 0,
        );
        NotificationCubit(instance()).saveNotification(
          request: NotificationRequest(
            userId: Globals.userData.id!,
            title: "الطلبات",
            message: "تم إلغاء طلبك بنجاح",
          ),
        );
        emit(CancelOrderSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(CancelOrderFailure());
      },
    );
  }

  Future deleteOrder({
    required int orderId,
  }) async {
    emit(DeleteOrderLoading());
    var response = await repo.deleteOrder(orderId: orderId);
    response.when(
      success: (NetworkBaseModel response) async {
        emit(DeleteOrderSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(DeleteOrderFailure());
      },
    );
  }
}
