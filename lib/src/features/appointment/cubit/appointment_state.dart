part of 'appointment_cubit.dart';

@immutable
sealed class AppointmentState {}

final class CalendarInitial extends AppointmentState {}

class GetPeriodsLoading extends AppointmentState {}
class GetPeriodsSuccess extends AppointmentState {}
class GetPeriodsFailure extends AppointmentState {}

class GetSpacesLoading extends AppointmentState {}
class GetSpacesSuccess extends AppointmentState {}
class GetSpacesFailure extends AppointmentState {}

class GetCalendarLoading extends AppointmentState {}
class GetCalendarSuccess extends AppointmentState {}
class GetCalendarFailure extends AppointmentState {}
