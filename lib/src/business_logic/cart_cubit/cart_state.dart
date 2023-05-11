part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddCartLoadingState extends CartState {}
class AddCartSuccessState extends CartState {}
class AddCartErrorState extends CartState {}

class DeleteCartLoadingState extends CartState {}
class DeleteCartSuccessState extends CartState {}
class DeleteCartErrorState extends CartState {}

class GetCartLoadingState extends CartState {}
class GetCartSuccessState extends CartState {}
class GetCartErrorState extends CartState {}
