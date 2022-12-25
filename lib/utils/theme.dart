import 'package:flutter/material.dart';
import 'package:oldbike/utils/colors.dart';

final ThemeData androidThemeData = ThemeData.dark().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: kcPrimary,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: kcAccent,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    iconColor: kcAccent,
  ),
  cardTheme: const CardTheme(
    color: kcPrimaryS2,
  ),
);
