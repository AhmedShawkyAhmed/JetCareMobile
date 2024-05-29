part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class AddToCartLoading extends CartState {}
class AddToCartSuccess extends CartState {}
class AddToCartFailure extends CartState {}

class DeleteFromCartLoading extends CartState {}
class DeleteFromCartSuccess extends CartState {}
class DeleteFromCartFailure extends CartState {}

class GetCartLoading extends CartState {}
class GetCartSuccess extends CartState {}
class GetCartFailure extends CartState {}
