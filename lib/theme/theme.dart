import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade400,
      primary: Colors.grey.shade300
    )
  );

ThemeData darkmode =
    ThemeData(brightness: Brightness.dark, 
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade800
    )
  );
