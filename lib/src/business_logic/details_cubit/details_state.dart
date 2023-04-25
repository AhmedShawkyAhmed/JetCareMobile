part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState {}
class DetailsSuccessState extends DetailsState {}
class DetailsErrorState extends DetailsState {}

class PackageLoadingState extends DetailsState {}
class PackageSuccessState extends DetailsState {}
class PackageErrorState extends DetailsState {}
