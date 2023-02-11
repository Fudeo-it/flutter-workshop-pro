import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LightTheme {
  static const primaryColor = Colors.blue;
  static const lightBlue = Color(0xFFE3F2FD);

  static get make => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          toolbarHeight: 80.0,
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: primaryColor,
            size: 36.0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: lightBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, height: 17 / 14),
          errorStyle: TextStyle(
            fontSize: 10,
            height: 0.6,
          ),
          errorMaxLines: 10,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: ThemeExtensions.resolveMaterialStateProperty(primaryColor),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: const CupertinoPageTransitionsBuilder(),
          },
        ),
      );
}

class DarkTheme {
  static const primaryColor = Colors.blue;
  static const darkBlack = Colors.black26;

  static get make => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          toolbarHeight: 80.0,
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: primaryColor,
            size: 36.0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: darkBlack,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, height: 17 / 14),
          errorStyle: TextStyle(
            fontSize: 10,
            height: 0.6,
          ),
          errorMaxLines: 10,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
            textStyle: const TextStyle(
              fontSize: 14.0,
            ),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: ThemeExtensions.resolveMaterialStateProperty(primaryColor),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: const CupertinoPageTransitionsBuilder(),
          },
        ),
      );
}

enum ThemeType {
  system,
  light,
  dark,
}

extension ThemeExtensions on ThemeType {
  static resolveMaterialStateProperty(Color color) =>
      MaterialStateProperty.resolveWith((states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };

        if (states.any(interactiveStates.contains)) {
          return color;
        }

        return null;
      });

  String? localize(BuildContext context) {
    switch (this) {
      case ThemeType.system:
        return AppLocalizations.of(context)?.theme_system;
      case ThemeType.light:
        return AppLocalizations.of(context)?.theme_light;
      case ThemeType.dark:
        return AppLocalizations.of(context)?.theme_dark;
    }
  }
}
