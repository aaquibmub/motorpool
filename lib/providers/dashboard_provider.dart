import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/user.dart';

import '../helpers/models/dashboard/dashboard_model.dart';

class DashboardProvider with ChangeNotifier {
  final String authToken;
  final User user;

  DashboardProvider(this.authToken, this.user);

  DashboardModel _dashboardModel;

  DashboardModel get dashboardModel {
    return _dashboardModel;
  }

  Future<void> populateDashboardModel() async {
    var url = '${Constants.baseUrl}dashboard/get-mobile-dashboard-model';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          // 'Content-Type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final extractedData = json.decode(response.body) as dynamic;
          _dashboardModel = DashboardModel.fromJson((extractedData));
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
