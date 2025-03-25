import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          displayMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          displaySmall: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
          bodySmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontFamily: 'Point',
          ),
        ),
      );
}
