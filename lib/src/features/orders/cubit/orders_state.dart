part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class GetMyOrdersLoading extends OrdersState {}
class GetMyOrdersSuccess extends OrdersState {}
class GetMyOrdersFailure extends OrdersState {}

class CreateOrderLoading extends OrdersState {}
class CreateOrderSuccess extends OrdersState {}
class CreateOrderFailure extends OrdersState {}

class CancelOrderLoading extends OrdersState {}
class CancelOrderSuccess extends OrdersState {}
class CancelOrderFailure extends OrdersState {}

class DeleteOrderLoading extends OrdersState {}
class DeleteOrderSuccess extends OrdersState {}
class DeleteOrderFailure extends OrdersState {}
