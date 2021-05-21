import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType { Light, Dark }
/// List of available colors for this theme
class ThemeColors {
  ///Primary actions, buttons, links & success states
  static const Color green50 = Color(0xFF30D7B9);
  ///Pressed states & creating gradients
  static const Color green40 = Color(0xFF3CE0C2);
  static const Color green80 = Color(0xFF33AA7B);
  static const Color grey = Color(0xFF96A1B2);
 static const Color greyShadow = Color(0xFFF9F9FA);
 static const Color black = Color(0xFF1D2635);
  static const Color blackNavy = Color(0xFF054750);
 static const Color red = Color(0xFFDE220B);
 static const Color greyLight = Color(0xFFE6E9EC);
 static const Color whiteGrey = Color(0xFFFCFCFC);
static const Color grey30 = Color(0xFFBDC5D1);
static const Color blackLight = Color(0xFF424E61);
}

/// Defined Style for Light and Dark Theme
class ThemeStyle {

  static const TextStyle hyperlink = TextStyle(color: ThemeColors.green50);

  static final TextStyle headerMedium14 = GoogleFonts.inter(
    fontSize: 14,
  );

  static final TextStyle bodyRegular14 = GoogleFonts.inter(
    fontSize: 14,
    color: ThemeColors.black
  );

    static final TextStyle bodyRegular14Title = GoogleFonts.roboto(
    fontSize: 14,
    color: ThemeColors.black
  );


  static final TextStyle bodyRegular15 = GoogleFonts.inter(
    fontSize: 15,
  );
  static final TextStyle bodyRegular16 = GoogleFonts.inter(
    fontSize: 16,
  );

  static final TextStyle bodyRegular18 = GoogleFonts.inter(
    fontSize: 18,
  );

  static final TextStyle bodyRegular12 = GoogleFonts.inter(
    fontSize: 12,
  );

  static final TextStyle bodyRegular10_5 = GoogleFonts.inter(
    fontSize: 10.5,
  );

  static final appThemeData = {
    ThemeType.Light: ThemeData.light().copyWith(
         pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),

          },
        ),
        primaryColor: ThemeColors.green50,
        primaryColorDark: ThemeColors.green80,
        primaryColorLight: ThemeColors.green40,
        buttonTheme: ButtonThemeData(
            buttonColor: ThemeColors.green50,
            textTheme: ButtonTextTheme.primary),
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 2,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
                headline6: ThemeStyle.bodyRegular18
                    .copyWith(color: Colors.black))),
        scaffoldBackgroundColor: ThemeColors.greyShadow,
        backgroundColor: Colors.white,
        snackBarTheme: SnackBarThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            )),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ThemeColors.green50,
        ),
        textTheme: TextTheme(
          bodyText1: bodyRegular14
          ,  bodyText2: bodyRegular14
        )
      ),
    ThemeType.Dark: ThemeData.dark().copyWith()
  };
}
