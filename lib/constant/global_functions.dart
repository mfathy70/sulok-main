import 'dart:developer';

import 'package:flutter/foundation.dart';

void securePrint(dynamic text) {
  if (kDebugMode) {
    log(text);
  }
}

void secureLog(String text, {required String name}) {
  if (kDebugMode) {
    log(text, name: name);
  }
}
