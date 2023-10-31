import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/common/response_model.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_detail.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/helpers/models/trips/trip.dart';
import 'package:motorpool/helpers/models/user.dart';

import '../helpers/models/trips/enroute/trip_vehical_meter_model.dart';

class TripProvider with ChangeNotifier {
  final String authToken;
  final User user;

  TripProvider(this.authToken, this.user);

  List<Trip> _upcomingTrips = [];

  List<Trip> get upcomingTrips {
    return [..._upcomingTrips];
  }

  Future<void> populateUpcomingTrips() async {
    var url = '${Constants.baseUrl}trip/get-upcoming-trip-list';
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
          final List<Trip> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              Trip prod = Trip.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _upcomingTrips = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Trip> _completedTrips = [];

  List<Trip> get completedTrips {
    return [..._completedTrips];
  }

  Future<void> populateCompletedTrips() async {
    var url = '${Constants.baseUrl}trip/get-completed-trip-list';
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
          final List<Trip> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              Trip prod = Trip.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _completedTrips = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Trip> _cancelledTrips = [];

  List<Trip> get cancelledTrips {
    return [..._cancelledTrips];
  }

  Future<void> populateCancelledTrips() async {
    var url = '${Constants.baseUrl}trip/get-cancelled-trip-list';
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
          final List<Trip> loadedProducts = [];
          if (extractedData != null) {
            extractedData.forEach((value) {
              Trip prod = Trip.fromJson((value));
              loadedProducts.add(prod);
            });
          }
          _cancelledTrips = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  TripDetail _tripDetail;

  TripDetail get tripDetail {
    return _tripDetail;
  }

  Future<void> populateTrip(String tripId) async {
    var url = '${Constants.baseUrl}trip/get-trip-detail?tripId=' + tripId;
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
          final value = json.decode(response.body) as dynamic;
          _tripDetail = TripDetail.fromJson((value));
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  TripEnroute _tripEnroute;

  TripEnroute get tripEnroute {
    return _tripEnroute;
  }

  Future<void> populateTripEnroute(String tripId) async {
    var url = '${Constants.baseUrl}trip/get-trip-enroute?tripId=' + tripId;
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
          final value = json.decode(response.body) as dynamic;
          _tripEnroute = TripEnroute.fromJson((value));
          notifyListeners();
          break;
        case HttpStatus.forbidden:
          break;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseModel<String>> updateStatus(TripStatusUpdate model) async {
    final url = '${Constants.baseUrl}trip/update-trip-status';
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(
          model.toJson(),
        ),
      )
          .then((response) {
        final responseData = json.decode(response.body);
        ResponseModel<String> result = ResponseModel.fromJson(responseData);
        return Future.value(result);
      });
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseModel<String>> updateTripVehicalMeter(
      TripVehicalMeterModel model) async {
    final url = '${Constants.baseUrl}trip/update-trip-vehical-meter';
    try {
      return await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(
          model.toJson(),
        ),
      )
          .then((response) {
        final responseData = json.decode(response.body);
        ResponseModel<String> result = ResponseModel.fromJson(responseData);
        return Future.value(result);
      });
    } catch (error) {
      throw error;
    }
  }
}
