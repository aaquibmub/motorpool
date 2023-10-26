import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/common/constants.dart';
import '../helpers/models/address/add_destination_model.dart';
import '../helpers/models/common/dropdown_item.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/user.dart';

class AddressProvider with ChangeNotifier {
  final String authToken;
  final User user;

  AddressProvider(
    this.authToken,
    this.user,
  );

  List<DropdownItem<String>> _addressList = [];

  List<DropdownItem<String>> get addressList {
    return _addressList;
  }

  Future<void> getDropDownList() async {
    var url = '${Constants.baseUrl}address/get-dropdown-list';
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
            _addressList = loadedProducts;
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

  ResponseModel<String> _addDestinationResponseModel;

  ResponseModel<String> get addDestinationResponseModel {
    return _addDestinationResponseModel;
  }

  Future<ResponseModel<String>> addDestination(
      AddDestinationModel model) async {
    final url = '${Constants.baseUrl}trip/add-trip-destination';
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
