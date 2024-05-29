part of 'support_cubit.dart';

@immutable
sealed class SupportState {}

final class SupportInitial extends SupportState {}

class GetInfoLoading extends SupportState {}
class GetInfoSuccess extends SupportState {}
class GetInfoFailure extends SupportState {}

class GetContactsLoading extends SupportState {}
class GetContactsSuccess extends SupportState {}
class GetContactsFailure extends SupportState {}

class AddSupportLoading extends SupportState {}
class AddSupportSuccess extends SupportState {}
class AddSupportFailure extends SupportState {}
