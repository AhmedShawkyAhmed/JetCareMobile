import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetcare/src/data/models/account_model.dart';
import 'package:jetcare/src/data/models/address_model.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/data/models/space_model.dart';
import 'package:jetcare/src/data/network/requests/order_summery.dart';

AccountModel globalAccountModel = AccountModel();
PeriodModel selectedPeriod = PeriodModel();
AddressModel selectedAddress = AddressModel();
SpaceModel selectedSpace = SpaceModel();
TextEditingController locationController = TextEditingController();
TextEditingController verifyCodeController = TextEditingController();
TextEditingController dateController = TextEditingController();
List<ItemModel> selectedExtra = [];
List<OrderSummery> orderSummery = [];
List<int> extrasIds = [];
List<int> cart = [];
num extrasPrice = 0;
num cartTotal = 0;
int verifyCode = 0;
LatLng addressLocation = const LatLng(0.0, 0.0);
dynamic dropDownValue;

disposeConstants(){
  extrasPrice = 0;
  cartTotal = 0;
  selectedPeriod = PeriodModel();
  selectedAddress = AddressModel();
  selectedSpace = SpaceModel();
  locationController.clear();
  verifyCodeController.clear();
  dateController.clear();
  extrasIds.clear();
  cart.clear();
  selectedExtra.clear();
}