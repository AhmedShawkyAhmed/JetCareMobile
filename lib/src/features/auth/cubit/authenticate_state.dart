part of 'authenticate_cubit.dart';

@immutable
sealed class AuthenticateState {}

final class AuthenticateInitial extends AuthenticateState {}

class AuthenticateLoading extends AuthenticateState {}

class AuthenticateSuccess extends AuthenticateState {}

class AuthenticateFailure extends AuthenticateState {}

class FCMLoadingState extends AuthenticateState {}
class FCMSuccessState extends AuthenticateState {}
class FCMErrorState extends AuthenticateState {}
