part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class GetHomeLoading extends HomeState {}
class GetHomeSuccess extends HomeState {}
class GetHomeFailure extends HomeState {}

class GetPackageLoading extends HomeState {}
class GetPackageSuccess extends HomeState {}
class GetPackageFailure extends HomeState {}

class GetCategoryLoading extends HomeState {}
class GetCategorySuccess extends HomeState {}
class GetCategoryFailure extends HomeState {}
