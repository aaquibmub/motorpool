import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = 'http://135.125.212.110:8095/api/';
  // static const String baseUrl = 'http://10.0.2.2:9000/api/';
  // static const String baseUrl = 'http://127.0.0.1:9000/';

  static const String clientID = '6a582387-93d6-4b35-8ab6-ce888083c804';
  static const String clientSecret = 'abc';

  // Theme
  // Fonts
  static const String fontFamilyMontserrat = 'Montserrat';
  static const String fontFamilyRoboto = 'Roboto';
  // Colors
  static final Color primaryColor = Color.fromRGBO(255, 105, 38, 1.0);
  static final Color textColor = Color.fromRGBO(69, 66, 101, 1.0);
  static final Color textColor1 = Color.fromRGBO(79, 86, 116, 1.0);
  static final Color textFieldFillColor = Color.fromRGBO(240, 245, 248, 1.0);
  static final Color textFieldHintColor = Color.fromRGBO(167, 166, 187, 1.0);
  static final Color colorGrey = Color.fromRGBO(194, 197, 206, 1.0);
  static final Color colorLightGrey = Color.fromRGBO(234, 237, 248, 1.0);
  static final Color colorGreen = Color.fromRGBO(57, 154, 120, 1.0);
  static final Color colorYellow = Color.fromRGBO(255, 233, 90, 1.0);
  static final Color colorPurpleDark = Color.fromRGBO(74, 48, 132, 1.0);
  static final Color colorBadgeBg = Color.fromRGBO(255, 242, 232, 1.0);
  static final Color colorBadgeTitle = Color.fromRGBO(68, 81, 83, 1.0);
  static final Color colorCardBorder = Color.fromRGBO(237, 239, 245, 1.0);

  static const double deviceTypePhoneMaxWidth = 500;
  static const double deviceTypeTabletMaxWidth = 1300;
  static const double deviceTypeMonitorMaxWidth = 2000;
}
