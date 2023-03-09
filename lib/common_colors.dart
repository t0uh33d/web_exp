// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonColors {
  static const Color primaryColor = Color(0xff436AF5);
  static const Color appBarTextColor = Color(0xff2A394E);
  static const Color scaffoldBackgroundColor = Color(0xfff4f4f5);
  static const Color progressBackgroundColor = Color(0xffecf0fe);
  static const Color progressColor = Color(0xff33c659);

  // text color
  static const Color textLightGreyColor = Color(0xff949CA6);
  static const Color textColorBottomBar = Color(0xff6A7483);

  static const Color primaryLightColor = Color(0xffECF0FE);
  static const Color darkIconColor = Color(0xff747E8B);

  static const Color darkGreenTextColor = Color(0xff218038);
  static const Color lightGreenBackgroundColor = Color(0xffEAF9EE);

  static const Color quizGradient = Color(0xffccd7ff);

  static const Color purpleLightBackgroundColor = Color(0xffF3F1FF);
  static const Color purpleDarkForegroundColor = Color(0xff6052AD);
  static const Color purpleUpcomingCourseBG = Color(0xffD9D2FF);
  static const Color greyOptionColor = Color(0xffC9CDD2);

  static const Color greyButtonColor = Color(0xffEAEBED);

  static const Color darkTextColor = Color(0xff1A2330);

  static const Color lightRedBackgroundColor = Color(0xffFFEBEA);
  static const Color darkRedTextColor = Color(0xffB52A21);

  static const Color logoutRedColor = Color(0xffFF3B2F);

  static const Color quizWrongOptionColor = Color(0xffC93400);

  static const Color onboardBackgroundColor = Color(0xffCED9FF);

  static const Color primaryColorShadow = Color(0xffE1E7FF);

  static const Color greyDotColor = Color(0xffD9D9D9);

  static List<ProfileColor> profileColors = [
    ProfileColor(
        foreground: const Color(0xff6584F6),
        background: const Color(0xffECF0FE)),
    ProfileColor(
        foreground: const Color(0xff8D78FF),
        background: const Color(0xffF3F1FF)),
    ProfileColor(
        foreground: const Color(0xff5CDB7B),
        background: const Color(0xffEAF9EE)),
    ProfileColor(
        foreground: const Color(0xffFE7B72),
        background: const Color(0xffFFEBEA)),
  ];

  static const Color dividerColors = Color(0xffF4F4F5);

  static const Color textColorCertificateShare = Color(0xff545454);

  static const Color menuIconColor = Color(0xff2B3A4F);

  static const Color appUpdateTextColor = Color(0xff879EF5);
}

class ProfileColor {
  final Color foreground;
  final Color background;
  ProfileColor({
    required this.foreground,
    required this.background,
  });
}
