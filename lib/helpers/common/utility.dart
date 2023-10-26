import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/routes.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../models/user.dart';
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
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static void errorAlert(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? "ERROR!"),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        });
  }

  static int getNextTripStatus(TripEnroute _tripEnroute) {
    final status = _tripEnroute.tripStatus;
    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      return TripStatus.Completed;
    }

    if (status == TripStatus.TripStarted) {
      return TripStatus.VehicalDispatched;
    }
    if (status == TripStatus.VehicalDispatched) {
      return TripStatus.ArrivedAtPickupLocation;
    }
    if (status == TripStatus.ArrivedAtPickupLocation) {
      return TripStatus.WaitingForPassenger;
    }
    if (status == TripStatus.WaitingForPassenger) {
      return TripStatus.PassengerOnboarded;
    }
    if (status == TripStatus.ArrivedAtStop) {
      return TripStatus.WaitingForStopActivity;
    }
    if (status == TripStatus.WaitingForPassenger) {
      return TripStatus.TripResumedAfterStop;
    }
    final destinationType = nextDestination.destinationType.value;
    if (destinationType == DestinationType.Pickup) {
      return TripStatus.ArrivedAtPickupLocation;
    } else if (destinationType == DestinationType.Stop) {
      return TripStatus.ArrivedAtStop;
    } else {
      return TripStatus.ArrivedAtDropoff;
    }
  }

  static String getNextTripDestinationId(TripEnroute _tripEnroute) {
    var index = _tripEnroute.items.length - 1;
    var tripEnrouteItem = _tripEnroute.items[index];
    var destinationId =
        tripEnrouteItem != null ? tripEnrouteItem.destinationId : null;

    return destinationId;
  }

  static String getNextTripAddressId(TripEnroute _tripEnroute) {
    var index = _tripEnroute.items.length - 1;
    var tripEnrouteItem = _tripEnroute.items[index];
    var address = tripEnrouteItem != null ? tripEnrouteItem.location : null;

    return address != null ? address.value : null;
  }

  static String getTripEnrouteButtonText(TripEnroute _tripEnroute) {
    final status = _tripEnroute.tripStatus;
    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      return "END TRIP";
    }

    if (status == TripStatus.TripStarted) {
      return "DISPATCH";
    }
    if (status == TripStatus.VehicalDispatched) {
      return "ARRIVED AT PICKUP";
    }
    if (status == TripStatus.ArrivedAtPickupLocation ||
        status == TripStatus.ArrivedAtStop) {
      return "RESUME TRIP";
    }
    if (status == TripStatus.WaitingForPassenger) {
      return "PASSENGER ON BOARDED";
    }
    return "ARRIVED AT " + nextDestination.destinationType.text.toUpperCase();
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

  static Map<T, List<S>> myGroupBy<S, T>(
      Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }

  static List<DropdownItem<int>> getDestinationTypeList() {
    return [
      DropdownItem(DestinationType.Pickup, 'Pickup'),
      DropdownItem(DestinationType.Stop, 'Stop'),
      DropdownItem(DestinationType.Dropoff, 'Dropoff'),
    ];
  }

  static String getDestinationTypeText(int type) {
    final list = getDestinationTypeList();
    final item = list.firstWhere((element) => element.value == type);
    return item != null ? item.text : '';
  }

  static List<DropdownItem<int>> getDamageLevelList() {
    return [
      DropdownItem(DamageLevel.S1, 'S1'),
      DropdownItem(DamageLevel.S2, 'S2'),
      DropdownItem(DamageLevel.D1, 'D1'),
      DropdownItem(DamageLevel.D2, 'D2'),
      DropdownItem(DamageLevel.M1, 'M1'),
      DropdownItem(DamageLevel.M2, 'M2'),
    ];
  }

  static Drawer buildDrawer(BuildContext context) {
    final User _currentuser = Provider.of<Auth>(context).currentUser;

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Constants.primaryColor,
            ),
            child: Text(
              'Hello, ' + (_currentuser != null ? _currentuser.firstName : ''),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.homeScreen,
              );
            },
          ),
          ListTile(
            title: const Text('Report an Incident'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.newIncidentScreen);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();
            },
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }
}
