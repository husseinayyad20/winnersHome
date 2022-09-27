import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#F4F5F7");
  static Color darkPrimary = HexColor.fromHex("#0B1828");
  static Color primaryColorLight = HexColor.fromHex("#D8DCE5");
  static Color primaryColorDark = HexColor.fromHex("#FFFFFF");
  static Color darkPrimaryColorLight = HexColor.fromHex("#14213C");
  static Color darkPrimaryColorDark = HexColor.fromHex("#13274A");
  static Color toggleableActiveColor = HexColor.fromHex("#7E8694");
  static Color accentColor = HexColor.fromHex("#2B8AF7");
  static Color lightGray = HexColor.fromHex("#AEB4BF");
  static Color gray = HexColor.fromHex("#AEB4BF");
  static Color appBarTextColor = HexColor.fromHex("#2F2F2F");
  static Color appBarIconColor = HexColor.fromHex("#C6C6C6");
  static Color appBarDarkBackgroundColor = HexColor.fromHex("#233355");
  static Color bottomNavigationBarBackgroundColor = HexColor.fromHex("#525C6E");
  static Color bottomNavigationBarDarkBackgroundColor =
      HexColor.fromHex("#263B69");
  static Color background = HexColor.fromHex("#E5E5E5");
  static Color backgroundDark = HexColor.fromHex("#212121");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color red = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#212121");
  static Color tabBarDarkBackground = HexColor.fromHex("#233355");
  static Color darkExpanded = HexColor.fromHex("#3B475F");
  static Color darkExpandedBackground = HexColor.fromHex("#3B475F");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
