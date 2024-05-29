part of 'address_cubit.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

class AddAddressLoading extends AddressState {}
class AddAddressSuccess extends AddressState {}
class AddAddressFailure extends AddressState {}

class UpdateAddressLoading extends AddressState {}
class UpdateAddressSuccess extends AddressState {}
class UpdateAddressFailure extends AddressState {}

class DeleteAddressLoading extends AddressState {}
class DeleteAddressSuccess extends AddressState {}
class DeleteAddressFailure extends AddressState {}

class GetAddressLoading extends AddressState {}
class GetAddressSuccess extends AddressState {}
class GetAddressFailure extends AddressState {}

class GetStatesLoading extends AddressState {}
class GetStatesSuccess extends AddressState {}
class GetStatesFailure extends AddressState {}

class GetAreasLoading extends AddressState {}
class GetAreasSuccess extends AddressState {}
class GetAreasFailure extends AddressState {}
