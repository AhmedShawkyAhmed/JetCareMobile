import 'package:flutter/foundation.dart';

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printSuccess(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printInfo(String text) {
  if (kDebugMode) {
    print('\x1B[34m$text\x1B[0m');
  }
}

