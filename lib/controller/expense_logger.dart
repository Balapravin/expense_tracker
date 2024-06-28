import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static debugPrint({dynamic titleMessage, printObject}) {
    if (kDebugMode) {
      if (printObject != null) {
        log("👉👉👉  $titleMessage  ---> $printObject  👈👈👈");
      } else {
        log("👉👉👉 $titleMessage  👈👈👈");
      }
    }
  }

  static successPrint({dynamic titleMessage, printObject}) {
    if (kDebugMode) {
      if (printObject != null) {
        log("👍👍👍  $titleMessage  ---> $printObject  👍👍👍");
      } else {
        log("👍👍👍 $titleMessage  👍👍👍");
      }
    }
  }

  static errorPrint({dynamic titleMessage, printObject}) {
    if (kDebugMode) {
      if (printObject != null) {
        log("👎👎👎  $titleMessage  ---> $printObject  👎👎👎");
      } else {
        log("👎👎👎  $titleMessage  👎👎👎");
      }
    }
  }

  static catchPrint({dynamic titleMessage, printObject}) {
    if (kDebugMode) {
      if (printObject != null) {
        log("🪲🪲🪲  $titleMessage  ---> $printObject  🪲🪲🪲");
      } else {
        log("🪲🪲🪲  $titleMessage  🪲🪲🪲");
      }
    }
  }
}
