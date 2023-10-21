import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motorpool/helpers/models/common/dropdown_item.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/incidents/incident_model.dart';
import '../helpers/models/user.dart';

class IncidentProvider with ChangeNotifier {
  final String authToken;
  final User user;

  IncidentProvider(
    this.authToken,
    this.user,
  );

  List<DropdownItem<String>> _categoryList = [];

  List<DropdownItem<String>> get categoryList {
    return _categoryList;
  }

  Future<void> getCategoryDropDownList() async {
    var url = '${Constants.baseUrl}incident/get-category-dropdown-list';
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
          final extractedData = json.decode(response.body) as List<dynamic>;
          final List<DropdownItem<String>> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              DropdownItem<String> prod =
                  DropdownItem<String>.fromJson((value));
              loadedProducts.add(prod);
            });
            _categoryList = loadedProducts;
          }
          notifyListeners();
          break;
        case HttpStatus.forbidden:
          break;
          return [];
      }
    } catch (error) {
      throw error;
    }
  }

  ResponseModel<String> _incidentResponseModel;

  ResponseModel<String> get incidentResponseModel {
    return _incidentResponseModel;
  }

  Future<ResponseModel<String>> createIncident(IncidentModel model) async {
    final url = '${Constants.baseUrl}incident';
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(model.toJson()),
      )
          .then((response) {
        if (response.statusCode == HttpStatus.forbidden) {
          return ResponseModel(null, 'Operation not allowed', true);
        }
        final responseData = json.decode(response.body);
        ResponseModel<String> result =
            ResponseModel<String>.fromJson(responseData);
        return result;
      }).onError((error, stackTrace) {
        throw error;
      });
    } catch (error) {
      throw error;
    }
  }
}
