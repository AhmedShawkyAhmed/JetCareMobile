import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetcare/src/data/network/requests/order_summery.dart';

TextEditingController dateController = TextEditingController();
List<OrderSummery> orderSummery = [];
List<int> extrasIds = [];
List<int> shipping = [];
num extrasPrice = 0;
String dropState = '';
String dropArea = '';
num cartTotal = 0;
LatLng addressLocation = const LatLng(0.0, 0.0);
dynamic dropDownValue;
