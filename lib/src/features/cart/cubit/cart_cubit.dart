import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/network/models/network_base_model.dart';
import 'package:jetcare/src/core/network/models/network_exceptions.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/cart/data/models/cart_item_model.dart';
import 'package:jetcare/src/features/cart/data/repo/cart_repo.dart';
import 'package:jetcare/src/features/cart/data/requests/cart_request.dart';
import 'package:jetcare/src/features/shared/ui/views/indicator_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.repo) : super(CartInitial());
  final CartRepo repo;

  List<CartItemModel>? cart;

  num get total =>
      cart?.fold(0, (total, item) => (total ?? 0) + (item.price ?? 0)) ?? 0;

  Future addToCart({
    required CartRequest request,
  }) async {
    if (request.count == 0) {
      DefaultToast.showMyToast(translate(AppStrings.enterQuantity));
      return;
    }
    IndicatorView.showIndicator();
    emit(AddToCartLoading());
    var response = await repo.addToCart(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        await Future.delayed(const Duration(milliseconds: 100), () {
          NavigationService.pushReplacementNamed(
            Routes.addedToCart,
          );
        });
        emit(AddToCartSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        NavigationService.pop();
        emit(AddToCartFailure());
      },
    );
  }

  Future deleteFromCart({
    required CartItemModel cartItem,
  }) async {
    IndicatorView.showIndicator();
    emit(DeleteFromCartLoading());
    var response = await repo.deleteFromCart(id: cartItem.id!);
    response.when(
      success: (NetworkBaseModel response) async {
        cart!.remove(cartItem);
        NavigationService.pop();
        emit(DeleteFromCartSuccess());
      },
      failure: (NetworkExceptions error) {
        NavigationService.pop();
        error.showError();
        emit(DeleteFromCartFailure());
      },
    );
  }

  Future getCart() async {
    emit(GetCartLoading());
    var response = await repo.getMyCart();
    response.when(
      success: (NetworkBaseModel response) async {
        cart = response.data;
        emit(GetCartSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetCartFailure());
      },
    );
  }
}
