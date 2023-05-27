import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/end_points.dart';
import 'package:jetcare/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetcare/src/data/network/responses/cart_response.dart';
import 'package:jetcare/src/data/network/responses/global_response.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  CartResponse? cartResponse;
  GlobalResponse? addToCartResponse,deleteToCartResponse;

  Future getMyCart({
    required int userId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      cart.clear();
      cartTotal = 0;
      emit(GetCartLoadingState());
      await DioHelper.getData(url: EndPoints.getMyCart, query: {
        "userId": userId,
      }).then((value) {
        printResponse(value.data.toString());
        cartResponse = CartResponse.fromJson(value.data);
        cartTotal = cartResponse!.total!;
        if(cartResponse!.status == 200){
          for(int i = 0; i < cartResponse!.cart!.length; i++){
            cart.add(cartResponse!.cart![i].id);
          }
        }
        emit(GetCartSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(GetCartErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetCartErrorState());
      printError(e.toString());
    }
  }

  Future addToCart({
    required int count,
    required double price,
    required VoidCallback afterSuccess,
     int? packageId,
     int? itemId,
  }) async {
    try {
      emit(AddCartLoadingState());
      await DioHelper.postData(
        url: EndPoints.addToCart,
        body: {
          'userId': globalAccountModel.id,
          'count': count,
          'price': price,
          'packageId': packageId,
          'itemId': itemId,
        },
      ).then((value) {
        addToCartResponse = GlobalResponse.fromJson(value.data);
        emit(AddCartSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddCartErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddCartErrorState());
      printError(e.toString());
    }
  }

  Future deleteFromCart({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteCartLoadingState());
      await DioHelper.postData(
        url: EndPoints.deleteFromCart,
        body: {
          'id': id,
        },
      ).then((value) {
        deleteToCartResponse = GlobalResponse.fromJson(value.data);
        emit(DeleteCartSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteCartErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteCartErrorState());
      printError(e.toString());
    }
  }
}
