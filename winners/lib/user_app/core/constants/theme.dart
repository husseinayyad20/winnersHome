// ignore_for_file: deprecated_member_use



import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  final darkTheme = ThemeData(
    canvasColor: const Color(0xFFFFFFFF),
    focusColor: const Color(0xFFFFFFFF),
    splashColor: const Color(0xFFFFFFFF),

    /// Background Color
    primaryColor: ColorManager.darkPrimary,

    /// Main Menu Color
    primaryColorLight: ColorManager.darkPrimaryColorLight,

    /// Main Menu Color
    //icons color
    hoverColor: const Color(0xFFFFFFFF),

    /// Sports Menu Color
    primaryColorDark: ColorManager.darkPrimaryColorDark,
    toggleableActiveColor: ColorManager.white,
    brightness: Brightness.dark,
    accentColor: ColorManager.accentColor,
    backgroundColor: ColorManager.backgroundDark,
    hintColor: ColorManager.gray,
    shadowColor: Colors.grey,
    cardColor: ColorManager.darkPrimary,
    // Text theme
    textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
          textStyle: getRegularStyle(
        color: ColorManager.lightGray,
      )),
      headline1: GoogleFonts.poppins(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s15)),
      headline2: GoogleFonts.poppins(
          textStyle: getSemiBoldStyle(
              color: ColorManager.lightGray, fontSize: FontSize.s15)),
      headline3: GoogleFonts.poppins(
          textStyle: getBoldStyle(
              color: ColorManager.lightGray, fontSize: FontSize.s15)),
      headline4: GoogleFonts.poppins(
          textStyle: getMediumStyle(
              color: ColorManager.lightGray, fontSize: FontSize.s12)),
      headline5: GoogleFonts.poppins(
          textStyle: getBoldStyle(
              color: ColorManager.accentColor, fontSize: FontSize.s15)),
      headline6: GoogleFonts.poppins(
          textStyle:
              getBoldStyle(color: ColorManager.white, fontSize: FontSize.s14)),
      caption: GoogleFonts.poppins(
          textStyle: getMediumStyle(
              color: ColorManager.white, fontSize: FontSize.s12)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.bottomNavigationBarDarkBackgroundColor,
        selectedItemColor: ColorManager.white,
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorManager.white)),
    // App bar theme
    appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.appBarDarkBackgroundColor,
        toolbarHeight: 66.6,
        iconTheme: IconThemeData(size: 25, color: ColorManager.appBarIconColor),
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s15)),
    //Tab Bar Theme
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ColorManager.lightGray,
      labelStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s12),
      unselectedLabelStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s12),
    ),

    // input decoration theme (text form field)
    listTileTheme: ListTileThemeData(
      tileColor: ColorManager.darkPrimaryColorDark,
    ),

    highlightColor: ColorManager.bottomNavigationBarDarkBackgroundColor,

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.black,

      // hint style
      hintStyle: GoogleFonts.poppins(
          color: ColorManager.lightGray,
          fontSize: 15,
          fontWeight: FontWeight.w400),

      // label style
      labelStyle: GoogleFonts.poppins(
          color: ColorManager.lightGray,
          fontSize: 13,
          fontWeight: FontWeight.w400),
    ),
    dividerColor: ColorManager.lightGray,
  );

  final lightTheme = ThemeData(
    canvasColor: const Color(0xFFFFFFFF),
    focusColor: ColorManager.accentColor,
    splashColor: HexColor.fromHex("#003169"),
    hoverColor: HexColor.fromHex("#4E4E4E"),

    /// Background Color
    primaryColor: ColorManager.primary,

    /// Main Menu Color
    primaryColorLight: ColorManager.primaryColorLight,

    /// Sports Menu Color
    primaryColorDark: ColorManager.primaryColorDark,
    listTileTheme: ListTileThemeData(
      tileColor: ColorManager.white,
      
      
    ),
    

    /// Used for OutlineButton BorderSide,
    toggleableActiveColor: ColorManager.toggleableActiveColor,
    brightness: Brightness.light,
    backgroundColor: ColorManager.background,
    highlightColor: ColorManager.bottomNavigationBarBackgroundColor,
    hintColor: ColorManager.black,
    shadowColor: Colors.grey,
    cardColor: Colors.black.withOpacity(0.1),
    // Text theme
    textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
          textStyle: getRegularStyle(
        color: ColorManager.lightGray,
      )),
      headline1: GoogleFonts.poppins(
          textStyle: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s15)),
      headline2: GoogleFonts.poppins(
          textStyle: getSemiBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s15)),
      headline3: GoogleFonts.poppins(
          textStyle:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s15)),
      headline4: GoogleFonts.poppins(
          textStyle: getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s12)),
      headline5: GoogleFonts.poppins(
          textStyle: getBoldStyle(
              color: ColorManager.accentColor, fontSize: FontSize.s15)),
      headline6: GoogleFonts.poppins(
          textStyle:
              getBoldStyle(color: ColorManager.gray, fontSize: FontSize.s14)),
      caption: GoogleFonts.poppins(
          textStyle: getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s12)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.bottomNavigationBarBackgroundColor,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorManager.white)),
    // App bar theme
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        toolbarHeight: 66.6,
        iconTheme: IconThemeData(size: 25, color: ColorManager.appBarIconColor),
        titleTextStyle: getRegularStyle(
            color: ColorManager.appBarTextColor, fontSize: FontSize.s15)),

    // input decoration theme (text form field)

    inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorManager.gray.withOpacity(0.1),
        // hint style
        hintStyle: GoogleFonts.poppins(
            fontSize: 15, color: ColorManager.gray.withOpacity(0.5)),

        // label style
        labelStyle: GoogleFonts.poppins(
          color: ColorManager.black,
          fontSize: 13,
        )),
    //Tab Bar Theme
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ColorManager.lightGray,
      labelStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s12),
      unselectedLabelStyle: getRegularStyle(
          color: ColorManager.lightGray, fontSize: FontSize.s12),
    ),

    /// BLUE COLOR
    accentColor: ColorManager.accentColor,
    accentIconTheme: IconThemeData(color: ColorManager.background),
    dividerColor: ColorManager.lightGray,
   
  );
}
