part of 'crew_cubit.dart';

@immutable
sealed class CrewState {}

final class CrewInitial extends CrewState {}

class UpdateOrderStatusLoading extends CrewState {}
class UpdateOrderStatusSuccess extends CrewState {}
class UpdateOrderStatusFailure extends CrewState {}

class RejectOrderLoading extends CrewState {}
class RejectOrderSuccess extends CrewState {}
class RejectOrderFailure extends CrewState {}

class GetMyTasksLoading extends CrewState {}
class GetMyTasksSuccess extends CrewState {}
class GetMyTasksFailure extends CrewState {}

class GetMyTasksHistoryLoading extends CrewState {}
class GetMyTasksHistorySuccess extends CrewState {}
class GetMyTasksHistoryFailure extends CrewState {}
