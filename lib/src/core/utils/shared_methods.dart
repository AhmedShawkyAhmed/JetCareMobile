import 'package:flutter/foundation.dart';

void printResponse(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printSuccess(Object? object) {
String text = "$object";
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void printError(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printLog(Object? object) {
  String text = "$object";
  if (kDebugMode) {
    print('\x1B[34m$text\x1B[0m');
  }
}

