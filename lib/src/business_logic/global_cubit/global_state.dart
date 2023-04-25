part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}
class GlobalLoading extends GlobalState {}
class GlobalSuccess extends GlobalState {}
class GlobalFailure extends GlobalState {}

class HomeLoadingState extends GlobalState {}
class HomeSuccessState extends GlobalState {}
class HomeErrorState extends GlobalState {}

class SupportLoadingState extends GlobalState {}
class SupportSuccessState extends GlobalState {}
class SupportErrorState extends GlobalState {}

class InfoLoadingState extends GlobalState {}
class InfoSuccessState extends GlobalState {}
class InfoErrorState extends GlobalState {}

class AreaLoadingState extends GlobalState {}
class AreaSuccessState extends GlobalState {}
class AreaErrorState extends GlobalState {}

class CalendarLoadingState extends GlobalState {}
class CalendarSuccessState extends GlobalState {}
class CalendarErrorState extends GlobalState {}

class PeriodLoadingState extends GlobalState {}
class PeriodSuccessState extends GlobalState {}
class PeriodErrorState extends GlobalState {}

class SpaceLoadingState extends GlobalState {}
class SpaceSuccessState extends GlobalState {}
class SpaceErrorState extends GlobalState {}
