import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/common/response_model.dart';
import 'package:motorpool/helpers/models/user.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_general_item_model.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';
import 'package:motorpool/helpers/models/vehicals/vehical_history.dart';

import '../helpers/models/vehicals/inspection/vehical_inspection_body_part_item_model.dart';

class VehicalProvider with ChangeNotifier {
  final String authToken;
  final User user;

  VehicalProvider(this.authToken, this.user);

  List<VehicalHistory> _vehicalHistory = [];

  List<VehicalHistory> get vehicalHistory {
    return [..._vehicalHistory];
  }

  Future<void> populateVehicalHistory() async {
    var url = '${Constants.baseUrl}vehical/get-vehical-history-list';
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
          final List<VehicalHistory> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              VehicalHistory prod = VehicalHistory.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _vehicalHistory = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  ResponseModel<VehicalInspectionModel> _inspectionResponseModel;

  ResponseModel<VehicalInspectionModel> get inspectionResponseModel {
    return _inspectionResponseModel;
  }

  Future<void> createInspection(String vehicalId) async {
    final url = '${Constants.baseUrl}vehical/create-inspection';
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({'vehicalId': vehicalId}),
      )
          .then((response) {
        final responseData = json.decode(response.body);
        ResponseModel<VehicalInspectionModel> result =
            ResponseModel<VehicalInspectionModel>.fromJson(responseData);
        _inspectionResponseModel = result;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> saveGeneralInspectionItem(
      VehicalInspectionGeneralItemModel model) async {
    final url = '${Constants.baseUrl}vehical/save-general-item';
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
        // final responseData = json.decode(response.body);
        // ResponseModel<VehicalInspectionModel> result =
        //     ResponseModel<VehicalInspectionModel>.fromJson(responseData);
        // _inspectionResponseModel = result;
        // notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> saveBodyInspectionItem(
      VehicalInspectionBodyPartItemModel model) async {
    final url = '${Constants.baseUrl}vehical/save-body-item';
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
        // final responseData = json.decode(response.body);
        // ResponseModel<VehicalInspectionModel> result =
        //     ResponseModel<VehicalInspectionModel>.fromJson(responseData);
        // _inspectionResponseModel = result;
        // notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }
}
