import 'package:flutter/material.dart';
import 'package:media_content_library/const/responsive/responsive_util.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtil.isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }
    if (ResponsiveUtil.isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }
}
