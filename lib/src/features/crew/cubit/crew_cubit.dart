import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/models/order_model.dart';
import 'package:jetcare/src/features/crew/data/repo/crew_repo.dart';
import 'package:jetcare/src/features/crew/data/requests/update_order_status_request.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit(this.repo) : super(CrewInitial());
  final CrewRepo repo;

  List<OrderModel>? myTasks, myTasksHistory;

  Future updateOrderStatus({
    required UpdateOrderStatusRequest request,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateOrderStatusLoading());
    var response = await repo.updateOrderStatus(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.crewLayout,
          (route) => false,
        );
        emit(UpdateOrderStatusSuccess());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        error.showError();
        emit(UpdateOrderStatusFailure());
      },
    );
  }

  Future rejectOrder({
    required int orderId,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateOrderStatusLoading());
    var response = await repo.rejectOrder(orderId: orderId);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pushNamedAndRemoveUntil(
          Routes.crewLayout,
          (route) => false,
        );
        emit(UpdateOrderStatusSuccess());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        error.showError();
        emit(UpdateOrderStatusFailure());
      },
    );
  }

  Future getMyTasks() async {
    myTasks?.clear();
    emit(GetMyTasksLoading());
    var response = await repo.getMyTasks();
    response.when(
      success: (NetworkBaseModel response) async {
        myTasks = response.data ?? [];
        emit(GetMyTasksSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetMyTasksFailure());
      },
    );
  }

  Future getMyTasksHistory() async {
    myTasksHistory?.clear();
    emit(GetMyTasksHistoryLoading());
    var response = await repo.getMyTasksHistory();
    response.when(
      success: (NetworkBaseModel response) async {
        myTasksHistory = response.data ?? [];
        emit(GetMyTasksHistorySuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetMyTasksHistoryFailure());
      },
    );
  }
}
