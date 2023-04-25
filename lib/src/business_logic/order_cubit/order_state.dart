part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class CorporateLoadingState extends OrderState {}
class CorporateSuccessState extends OrderState {}
class CorporateErrorState extends OrderState {}

class MyOrdersLoadingState extends OrderState {}
class MyOrdersSuccessState extends OrderState {}
class MyOrdersErrorState extends OrderState {}

class OrdersLoadingState extends OrderState {}
class OrdersSuccessState extends OrderState {}
class OrdersErrorState extends OrderState {}

class MyTasksLoadingState extends OrderState {}
class MyTasksSuccessState extends OrderState {}
class MyTasksErrorState extends OrderState {}

class RejectOrderLoadingState extends OrderState {}
class RejectOrderSuccessState extends OrderState {}
class RejectOrderErrorState extends OrderState {}

class UpdateOrderStatusLoadingState extends OrderState {}
class UpdateOrderStatusSuccessState extends OrderState {}
class UpdateOrderStatusErrorState extends OrderState {}

class DeleteOrderStatusLoadingState extends OrderState {}
class DeleteOrderStatusSuccessState extends OrderState {}
class DeleteOrderStatusErrorState extends OrderState {}