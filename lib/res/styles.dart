import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

ThemeData buildThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    textTheme: buildAppTextTheme(),
    appBarTheme: buildAppBarTheme(),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      textStyle: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontFamily: 'Roboto',
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.blue,
      unselectedLabelColor: AppColors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(
        vertical: 9,
      ),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.blue,
            width: 3.0,
          ),
        ),
      ),
    ),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme buildAppTextTheme() {
  return TextTheme(
    headline1: TextStyle(
      fontSize: 18,
      height: 23 / 18,
      color: AppColors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      fontSize: 17,
      height: 22 / 17,
      fontFamily: 'Roboto',
      color: AppColors.black,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.41,
    ),
    headline3: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      color: AppColors.manatee,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      letterSpacing: 0.25,
    ),
    headline4: TextStyle(
      fontSize: 14,
      height: 16 / 14,
      color: AppColors.alto,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      letterSpacing: 0.75,
    ),
    headline5: TextStyle(
      fontSize: 13,
      height: 18 / 13,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontFamily: 'Roboto',
    ),
    headline6: TextStyle(
      fontSize: 12,
      height: 20 / 12,
      letterSpacing: -0.24,
      fontWeight: FontWeight.w300,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
    ),
  );
}

AppBarTheme buildAppBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    elevation: 0,
    color: AppColors.white,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        height: 23 / 18,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black26,
    ),
  );
}
