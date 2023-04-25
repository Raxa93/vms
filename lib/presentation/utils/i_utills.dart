

// ignore_for_file: camel_case_types

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class iUtills {


  showMessage({required BuildContext context, required String title, required String text}) {
    return Flushbar(
      title: title,
      message: text,
      duration: const Duration(seconds: 3),
      backgroundGradient: const LinearGradient(colors: [
        Color(0xffFFA37C),
        Color(0xffFE7940),
        Color(0xffFF9A70),
      ]),
    )..show(context);
  }


}