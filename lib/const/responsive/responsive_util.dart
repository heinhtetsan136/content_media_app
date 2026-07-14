import 'package:flutter/cupertino.dart';

class ResponsiveUtil {
  ResponsiveUtil._();
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 900;
  static bool isMoblie(BuildContext context) {
    return MediaQuery.of(context).size.width <=
        mobileMaxWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(
      context,
    ).size.width;
    return width > mobileMaxWidth &&
        width <= tabletMaxWidth;
  }
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >
        tabletMaxWidth;
  }
}
