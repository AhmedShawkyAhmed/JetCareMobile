part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {}

class RestoreAccountLoading extends ProfileState {}

class RestoreAccountSuccess extends ProfileState {}

class RestoreAccountFailure extends ProfileState {}
