import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';

import 'shared_types.dart';

class Utility {
  static dynamic getValuebyDeviceSize(
      Size deviceSize, dynamic phone, dynamic tablet, dynamic monitor) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? tablet
            : monitor;
  }

  static DeviceType getDeviceType(Size deviceSize) {
    return deviceSize.width < Constants.deviceTypePhoneMaxWidth
        ? DeviceType.Phone
        : deviceSize.width < Constants.deviceTypeTabletMaxWidth
            ? DeviceType.Tablet
            : DeviceType.Monitor;
  }

  static bool isPhone(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Phone;
  }

  static bool isTablet(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Tablet;
  }

  static bool isMonitor(Size deviceSize) {
    return Utility.getDeviceType(deviceSize) == DeviceType.Monitor;
  }

  static double getPercentageValue(double maxValue, double percentage) {
    return ((percentage / 100) * maxValue);
  }

  static String convertBase64StringToJsonString(String base64String) {
    return utf8.decode(base64.decode(base64String));
  }

  static String convertStringToBase64String(String str) {
    return base64.encode(utf8.encode(str));
  }

  static void toBeImplemented(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Work in progress'),
            content: Text('To be implemented'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static int getNextTripStatus(int status) {
    switch (status) {
      case TripStatus.TripStarted:
        {
          return TripStatus.VehicalDispatched;
        }
      case TripStatus.VehicalDispatched:
        {
          return TripStatus.ArrivedAtPickupLocation;
        }
      case TripStatus.ArrivedAtPickupLocation:
        {
          return TripStatus.WaitingForPassenger;
        }
      case TripStatus.WaitingForPassenger:
        {
          return TripStatus.PassengerOnboarded;
        }
      case TripStatus.PassengerOnboarded:
        {
          return TripStatus.ArrivedAtStop;
        }
      case TripStatus.ArrivedAtStop:
        {
          return TripStatus.ArrivedAtDropoff;
        }
    }
    return 0;
  }

  static String getNextTripAddressId(TripEnroute _tripEnroute) {
    var index = _tripEnroute.items.length - 1;
    var tripEnrouteItem = _tripEnroute.items[index];
    var address = tripEnrouteItem != null ? tripEnrouteItem.location : null;

    return address != null ? address.value : null;
  }

  static String getTripEnrouteButtonText(int status) {
    switch (status) {
      case TripStatus.TripStarted:
        {
          return "DISPATCH";
        }
      case TripStatus.VehicalDispatched:
        {
          return "ARRIVED AT PICKUP";
        }
      case TripStatus.ArrivedAtPickupLocation:
        {
          return "RESUME TRIP";
        }
      case TripStatus.WaitingForPassenger:
        {
          return "PASSENGER ON BOARDED";
        }
      case TripStatus.PassengerOnboarded:
        {
          return "ARRIVED AT STOP";
        }
      case TripStatus.ArrivedAtStop:
        {
          return "ARRIVED AT DROPOFF";
        }
    }
    return "";
  }

  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // if (hours == 0) {
    //   return "$minutesStr:$secondsStr";
    // }

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
