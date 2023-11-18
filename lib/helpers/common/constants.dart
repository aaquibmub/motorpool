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
  static const Color primaryColor = Color.fromRGBO(111, 66, 193, 1.0);
  static const Color textColor = Color.fromRGBO(69, 66, 101, 1.0);
  static const Color textColorLight = Color.fromRGBO(143, 155, 166, 1.0);
  static const Color textColor1 = Color.fromRGBO(79, 86, 116, 1.0);
  static const Color textFieldFillColor = Color.fromRGBO(240, 245, 248, 1.0);
  static const Color textFieldHintColor = Color.fromRGBO(167, 166, 187, 1.0);
  static const Color colorOrange = Color.fromRGBO(255, 105, 38, 1.0);
  static const Color colorGrey = Color.fromRGBO(194, 197, 206, 1.0);
  static const Color colorLightGrey = Color.fromRGBO(248, 249, 253, 1.0);
  static const Color colorGreen = Color.fromRGBO(48, 190, 67, 1.0);
  static const Color colorDarkGreen = Color.fromRGBO(39, 190, 67, 1.0);
  static const Color colorLightGreen = Color.fromRGBO(234, 255, 237, 1.0);
  static const Color colorYellow = Color.fromRGBO(255, 251, 224, 1.0);
  static const Color colorDarkYellow = Color.fromRGBO(247, 239, 185, 1.0);
  static const Color colorPurpleDark = Color.fromRGBO(74, 48, 132, 1.0);
  static const Color colorBadgeBg = Color.fromRGBO(255, 242, 232, 1.0);
  static const Color colorBadgeTitle = Color.fromRGBO(68, 81, 83, 1.0);
  static const Color colorCardBorder = Color.fromRGBO(237, 239, 245, 1.0);

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
  static const String vehicalBodyPartFrontSideLeftHeadlightId =
      '05aedf8a-e5d9-4311-b5b2-be5aceab2d3e';
  static const String vehicalBodyPartFrontSideRightHeadlightId =
      '175ae19c-d3cf-4cc9-ae6e-3034520aeea1';
  static const String vehicalBodyPartFrontSideFrontBumperId =
      '01f513e3-e203-43ab-b555-01b625e8f1c9';

  static const String vehicalBodyPartBackSideWindshieldId =
      'da229dc6-c16f-455c-9e73-8dff86d37d8b';
  static const String vehicalBodyPartBackSideLeftTaillightId =
      'ba22b392-a14d-43db-9a10-a11e9d1766e2';
  static const String vehicalBodyPartBackSideRightTaillightId =
      'd8c20675-3476-4313-971e-20cf5277495e';
  static const String vehicalBodyPartBackSideTrunkId =
      '65573644-2be4-4a8b-bc4c-48876bd89133';
  static const String vehicalBodyPartBackSideRearBumperId =
      '66268b36-8e5a-492d-835c-fc7f1e33c00f';

  static const String vehicalBodyPartRoofSideRoofId =
      '77835bf6-bd8b-4ddf-bc0f-32369212b3e4';
  static const String vehicalBodyPartRoofSideSunRoofId =
      '52dd1c2b-0727-4f15-b9d0-0f7c16ed2e76';

  static const String vehicalBodyPartLeftSideFrontFenderId =
      'c1ade3dc-3dfe-4215-a9ea-7e6f18f9cf8e';
  static const String vehicalBodyPartLeftSideRearFenderId =
      'ab0f2381-c934-47ed-a72f-8c71b7ec8df7';
  static const String vehicalBodyPartLeftSideSideMirrorId =
      '5f2d2937-307b-4c0e-84c9-ebdd5e72404e';
  static const String vehicalBodyPartLeftSideFrontWheelId =
      '697f1ed6-a7f5-4eed-8a0a-36b6b1d8d6f6';
  static const String vehicalBodyPartLeftSideRearWheelId =
      '1e2e34ea-4870-4d78-82df-37a96b91cc76';
  static const String vehicalBodyPartLeftSideFrontDoorId =
      '562b69a5-19ba-47a8-a169-f56e5a7c3b75';
  static const String vehicalBodyPartLeftSideRearDoorId =
      'd3da6558-ef86-441f-8adc-e0ec81d250e9';

  static const String vehicalBodyPartRightSideFrontFenderId =
      '573e0147-b1b8-45e4-94d6-cc77cea77da0';
  static const String vehicalBodyPartRightSideRearFenderId =
      '138401a1-63ef-4c00-a33e-0d22e9ecd024';
  static const String vehicalBodyPartRightSideSideMirrorId =
      '29c599c6-8850-4546-9fe6-6ecb11dc0e18';
  static const String vehicalBodyPartRightSideFrontWheelId =
      '8fa23015-b398-48a2-8293-663e0af5d0de';
  static const String vehicalBodyPartRightSideRearWheelId =
      '07ff9106-ff4c-4f87-9eb1-f43f8c0257e8';
  static const String vehicalBodyPartRightSideFrontDoorId =
      '84c32806-4f56-4b53-a8c2-4f50b070abd7';
  static const String vehicalBodyPartRightSideRearDoorId =
      'd1e16d16-cdbe-4e63-9ead-fb31a5cfa05a';
}
