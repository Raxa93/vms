import 'package:flutter/material.dart';
import '../configurations/size_config.dart';



class AppStyle {

  static  TextStyle headline1 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    fontSize: SizeConfig.screenHeight! * 0.05,
  );
  static const TextStyle headline2 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );
  static const TextStyle headline3 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static const TextStyle headline4 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle bodyText1 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    fontSize: 16,
  );
  static const TextStyle bodyText2 = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );
  static const TextStyle button = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );
  static final borderedContainer = BoxDecoration(
      color: Colors.grey[200],
      border: Border.all(
        color: Colors.black,
        width: 2,
      ));

  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    // backgroundColor: AppColors.primary,
    textStyle: AppStyle.button,
    shape: const RoundedRectangleBorder(
      borderRadius:
      BorderRadius.all(Radius.circular(10)),
    ),
  );
}