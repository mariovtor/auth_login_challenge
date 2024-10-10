import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xff7A5D3E);
  static const surfaceBright = Color(0xfff8f8fa);

  static final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

  static ThemeData theme(context) => ThemeData(
        primaryColor: primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(primary),
            overlayColor:
                WidgetStateProperty.all(Colors.black.withOpacity(.04)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppTheme.primary),
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(.5)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            backgroundBuilder: (context, states, child) {
              return Container(
                width: double.infinity,
                color: states.contains(WidgetState.disabled)
                    ? Colors.grey
                    : AppTheme.primary,
                child: child,
              );
            },
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 14),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontFamily: fontFamily),
          titleMedium: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontFamily: fontFamily),
          titleSmall: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontFamily: fontFamily),
          bodyLarge: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontFamily: fontFamily),
          bodyMedium: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontFamily: fontFamily),
          bodySmall: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontFamily: fontFamily),
          labelLarge: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontFamily: fontFamily),
          labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontFamily: fontFamily,
              ),
          labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontFamily: fontFamily,
              ),
          displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontFamily: fontFamily,
              ),
          displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontFamily: fontFamily,
              ),
          displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontFamily: fontFamily,
              ),
        ),
      );
}
