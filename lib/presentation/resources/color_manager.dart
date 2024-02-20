import 'package:flutter/material.dart';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color primary = HexColor.fromHex("#FFFFFF");
  static Color secondary = HexColor.fromHex("#4885ED");
  static Color stateRendererTextColor = HexColor.fromHex("#6B7280");
  static Color textColor = HexColor.fromHex("#6B7280");
  static Color greyColor = HexColor.fromHex("#F9FAFB");
  static Color greyBorder = HexColor.fromHex("#E5E7EB");



  static Color loginLogsRed = HexColor.fromHex("#FA8A8A");
  static Color errorColor = const Color(0xFFF61515);
  static Color borderColor = HexColor.fromHex("#4D4362");
  static Color primaryButtonColor = HexColor.fromHex("#111827");
  static Color authPlaceholderTextColor = HexColor.fromHex("#8193AA");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color textFieldTextColor = HexColor.fromHex("#252525");
  static Color smartpayGreen2 = HexColor.fromHex("#34A853");
  static Color grey = HexColor.fromHex("#737477");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black= HexColor.fromHex("#000000"); // black color
  static Color greenbase = HexColor.fromHex("#0A6375");
  static Color primarybase = HexColor.fromHex("#2FA2B9");

}


extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
