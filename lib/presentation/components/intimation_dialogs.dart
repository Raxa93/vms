
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants/app_colors.dart';

class UserIntimationWidgets{

  static getProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightBlue),
        ));
  }

  static showToast(String text) {
    EasyLoading.showToast(
      text,
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }
}