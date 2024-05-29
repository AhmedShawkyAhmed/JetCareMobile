import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/data/models/space_model.dart';
import 'package:jetcare/src/data/network/requests/order_summery.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';

PeriodModel selectedPeriod = PeriodModel();
AddressModel selectedAddress = AddressModel(id: -1);
SpaceModel selectedSpace = SpaceModel();
TextEditingController dateController = TextEditingController();
List<ItemModel> selectedExtra = [];
List<PeriodModel> discountPeriods = [];
AreaModel discountAreas = AreaModel(id: -1);
List<OrderSummery> orderSummery = [];
List<int> extrasIds = [];
List<int> cart = [];
List<int> shipping = [];
num extrasPrice = 0;
String dropState = '';
String dropArea = '';
num cartTotal = 0;
LatLng addressLocation = const LatLng(0.0, 0.0);
dynamic dropDownValue;

