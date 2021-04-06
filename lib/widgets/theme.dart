import 'package:flutter/material.dart';

ThemeData buildTheme(bool theme) {
  
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontSize: 24,
          color: theme?Colors.black:Colors.white,
        ),
        // Used for the title:
        headline6: base.headline6.copyWith(
          fontSize: 22.0,
          color: theme? Colors.black:Colors.white,
        ),
        subtitle1: base.subtitle1.copyWith(
          fontSize: 22.0,
        ),
        bodyText2: base.bodyText2.copyWith(color: const Color(0xFF807A6B)));
  }

  ThemeData base;
  // We want to override a default light blue theme.
  if (theme) //theme true = light theme
     base = ThemeData.light();
  else
     base = ThemeData.dark();

  // And apply changes on it:
  return base.copyWith(
    appBarTheme: AppBarTheme(
            color: theme? const Color(0xFFE5AE86) : const Color(0xFFe3bb9d),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black, fontSize: 24),
                headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
      textTheme: _buildTextTheme(base.textTheme),
      cardColor: theme? const Color(0xFFE5AE86) : const Color(0xFFe3bb9d),
      scaffoldBackgroundColor: theme? Colors.white : Colors.black,
      iconTheme: IconThemeData(
        color: theme? Colors.black : Colors.white,
        size: 20.0,
      ),
      buttonColor: theme?  Colors.amber : Colors.red,
      floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor:theme?  Colors.amber : Colors.red,backgroundColor: theme?  Colors.amber : Colors.red),
      backgroundColor:theme?  Colors.amber : Colors.red,
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: const Color(0xFF807A6B),
        unselectedLabelColor: const Color(0xFFCCC5AF),
      ));
}
