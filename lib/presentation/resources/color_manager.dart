import 'package:flutter/material.dart';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color primary = HexColor.fromHex("#FFFFFF");
  static Color secondary = HexColor.fromHex("#4885ED");
  static Color activationCodeTextColor = HexColor.fromHex("#032048");
  static Color landingPageDescriptionColor = HexColor.fromHex("#586F8E");
  static Color stateRendererTextColor = HexColor.fromHex("#042756");
  static Color oneCareGreen = HexColor.fromHex("#34A853");
  static Color oneCareGreen2 = HexColor.fromHex("#34A853");
  // static Color oneCareGreen = HexColor.fromHex("#2E953E");
  // static Color oneCareGreen2 = HexColor.fromHex("#37B34A");
  static Color footerTextColor = HexColor.fromHex("#8193AA");
  static Color tagColor = HexColor.fromHex("#E5E7E9");
  static Color tagTextColor = HexColor.fromHex("#949594");
  static Color signUpBackgroundColor = HexColor.fromHex("#F2F2F2");
  static Color editProfileBackgroundColor = HexColor.fromHex("#F8FAFE");
  static Color authPlaceholderTextColor = HexColor.fromHex("#8193AA");
  static Color primaryButtonColor = HexColor.fromHex("#37B34A");
  static Color buttonDisabledColor = HexColor.fromHex("#9BD9A5");
  static Color blueRoutingColor = HexColor.fromHex("#6179F5");
  static Color blueRoutingColor2 = HexColor.fromHex("#1660C1");
  static Color blueButtonColor = HexColor.fromHex("#1A73E8");
  static Color specialRoutingColor = HexColor.fromHex("#5D20D2");
  static Color iconGrey = HexColor.fromHex("#545252");
  static Color bottomNavBarBackgroundColor = const Color.fromRGBO(170, 196, 229, 0.15);
  static Color bottomNavBarActiveColor = HexColor.fromHex("#032048");
  static Color bottomNavBarInActiveColor = HexColor.fromHex("#D4E1F2");
  static Color documentListBackgroundColor = HexColor.fromHex("#FAFAFA");
  static Color loginLogsListBackgroundColor = HexColor.fromHex("#AAC4E5");
  static Color loginLogsGreen = HexColor.fromHex("#9BD9A4");
  static Color loginLogsRed = HexColor.fromHex("#FA8A8A");
  static Color loginLogsRedText = HexColor.fromHex("#F61515");
  static Color billingStatusRedText = HexColor.fromHex("#F73C3C");
  static Color receivedMessageBackgroundColor = HexColor.fromHex("#D4E1F2");
  static Color videoCallTopSectionColor = HexColor.fromHex("#81BAFF");
  static Color clinicalVitalsBackgroundColor = const Color.fromRGBO(198, 216, 238, 0.25);

  static Color summaryBorderColor = HexColor.fromHex("#A98B20");
  static Color appointmentBorderColor = HexColor.fromHex("#5B9A1B");
  static Color billingBorderColor = HexColor.fromHex("#690D94");
  static Color medicationBorderColor = HexColor.fromHex("#0A7981");
  static Color testResultBorderColor = HexColor.fromHex("#8B0E0E");
  static Color documentBorderColor = HexColor.fromHex("#86076A");
  static Color reminderBorderColor = HexColor.fromHex("#2D0A8F");
  static Color schedulingBorderColor = HexColor.fromHex("#1A73E8");
  static Color resourcesBorderColor = HexColor.fromHex("#925105");

  static Color neutralColor =  HexColor.fromHex("#8EA3BF");
  static Color borderColor = HexColor.fromHex("#4D4362");
  static Color textFieldTextColor = HexColor.fromHex("#252525");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color searchProviderFillColor =  const Color.fromRGBO(196, 195, 195,0.25);
  static Color searchFillColor =  const Color.fromRGBO(196, 195, 195,0.15);
  static Color circleAvatarGrey = HexColor.fromHex("#D9D9D9");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color hintGrey = const Color(0xFFA4A4A4);
  static Color messageInactiveLabelColor = HexColor.fromHex("#B8CEE9");
  static Color messageInactiveIndicatorColor = HexColor.fromHex("#C6D8EE");
  static Color textFieldBorder = const Color(0x0f949494);
  static Color onecareGrey = const Color(0xFF8F8D8D);
  static Color onecareGrey2 = const Color(0xFFB4B4B4);

  static Color neutralMain = const Color(0xFFAAC4E5);
  static Color neutralText = const Color(0xFF8EA3BF);
  static Color dInputHint = const Color.fromARGB(1, 44, 65, 92).withOpacity(0.6);
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
// new colors
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color errorColor = const Color(0xFFF61515);
  static Color searchGrey = const Color(0xFFD3D3D3);
  static Color searchGrey2 = HexColor.fromHex("#4D4362");
  static Color grey1 = HexColor.fromHex("#E5E5E5");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color grey3 = HexColor.fromHex("#2E4B72");
  static Color grey4 = HexColor.fromHex("#8E8E93");

  static Color error = HexColor.fromHex("#e61f34");
  static Color reminderError = HexColor.fromHex("#CD1111");
  static Color black= HexColor.fromHex("#000000"); // black color
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
