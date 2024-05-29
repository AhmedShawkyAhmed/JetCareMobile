part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}
class UpdateProfileSuccess extends ProfileState {}
class UpdateProfileFailure extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {}
class ProfileFailure extends ProfileState {}

class DeleteAccountLoading extends ProfileState {}
class DeleteAccountSuccess extends ProfileState {}
class DeleteAccountFailure extends ProfileState {}

class RestoreAccountLoading extends ProfileState {}
class RestoreAccountSuccess extends ProfileState {}
class RestoreAccountFailure extends ProfileState {}
