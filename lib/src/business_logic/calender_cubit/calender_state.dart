part of 'calender_cubit.dart';

@immutable
abstract class CalenderState {}

class CalenderInitial extends CalenderState {}

class GetCalenderInitial extends CalenderState {}
class GetCalenderSuccess extends CalenderState {}
class GetCalenderError extends CalenderState {}
