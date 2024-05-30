part of 'corporate_cubit.dart';

@immutable
sealed class CorporateState {}

final class CorporateInitial extends CorporateState {}

class GetCorporateOrdersLoading extends CorporateState {}
class GetCorporateOrdersSuccess extends CorporateState {}
class GetCorporateOrdersFailure extends CorporateState {}

class AddCorporateLoading extends CorporateState {}
class AddCorporateSuccess extends CorporateState {}
class AddCorporateFailure extends CorporateState {}
