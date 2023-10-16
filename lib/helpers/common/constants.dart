import 'package:flutter/material.dart';

class Constants {
  // static const String baseUrl = 'http://135.125.212.110:8095/api/';
  static const String baseUrl = 'http://10.0.2.2:9000/api/';
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

  static const String vehicalBodySideFrontId =
      'b6bfcb18-00b6-4a59-84e5-6e0e87c61a7a';
  static const String vehicalBodySideBackId =
      '1f84df08-ed57-482c-8b33-8961a3b783fa';
  static const String vehicalBodySideRoofId =
      'b9077876-7883-4ac6-bb35-a315d861e1be';
  static const String vehicalBodySideLeftId =
      '3bd60e05-e22d-4e61-94b4-a600e0e6e645';
  static const String vehicalBodySideRightId =
      'ae5ab2d4-409c-4b7e-a3a8-9b6a2c2953bc';

  static const String vehicalBodyPartFrontSideWindshieldId =
      '3d6c14df-efc4-411e-a474-f935f4ef51eb';
  static const String vehicalBodyPartFrontSideHoodId =
      '299e06fd-639c-44dd-bdb7-b77869cde9f4';
  static const String vehicalBodyPartFrontSideGrillId =
      '552a1408-122e-4309-a7c9-64aa9f1f359d';

  static const String vehicalBodyPartBackSideWindshieldId =
      'da229dc6-c16f-455c-9e73-8dff86d37d8b';

  static const String vehicalBodyPartRoofSideRoofId =
      '77835bf6-bd8b-4ddf-bc0f-32369212b3e4';

  static const String vehicalBodyPartLeftSideFrontFenderId =
      'c1ade3dc-3dfe-4215-a9ea-7e6f18f9cf8e';
  static const String vehicalBodyPartLeftSideSideMirrorId =
      '5f2d2937-307b-4c0e-84c9-ebdd5e72404e';

  static const String vehicalBodyPartRightSideFrontFenderId =
      '573e0147-b1b8-45e4-94d6-cc77cea77da0';
  static const String vehicalBodyPartRightSideSideMirrorId =
      '29c599c6-8850-4546-9fe6-6ecb11dc0e18';
}
