part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}


class AuthInitial extends AuthState {}

class ChangePasswordState extends AuthState {}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginErrorState extends AuthState {}

class CheckEmailLoadingState extends AuthState {}
class CheckEmailSuccessState extends AuthState {}
class CheckEmailErrorState extends AuthState {}

class SendEmailLoadingState extends AuthState {}
class SendEmailSuccessState extends AuthState {}
class SendEmailErrorState extends AuthState {}

class ResetPasswordLoadingState extends AuthState {}
class ResetPasswordSuccessState extends AuthState {}
class ResetPasswordErrorState extends AuthState {}

class DeleteLoadingState extends AuthState {}
class DeleteSuccessState extends AuthState {}
class DeleteErrorState extends AuthState {}

class UpdateLoadingState extends AuthState {}
class UpdateSuccessState extends AuthState {}
class UpdateErrorState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {}