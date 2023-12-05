import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/routes.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/vehical_provider.dart';
import '../models/user.dart';
import '../models/vehicals/deallocate_vehical_model.dart';
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

    if (status == TripStatus.OdoMeterAtEnd) {
      return TripStatus.Completed;
    }

    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      return TripStatus.OdoMeterAtEnd;
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

    if (status == TripStatus.OdoMeterAtEnd) {
      return "END TRIP";
    }

    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      return "METER READING";
    }

    if (status == TripStatus.OdoMeterAtStart) {
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

    Widget buildMenuItem(
      BuildContext context,
      String title,
      Function onTap,
    ) {
      return InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: onTap,
      );
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Constants.primaryColor,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      (_currentuser != null ? _currentuser.firstName : ''),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 16,
                          ),
                          child: Text(
                            'STATUS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          'LOGGED IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildMenuItem(
                        context,
                        'Home',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.homeScreen,
                          );
                        },
                      ),
                      buildMenuItem(
                        context,
                        'Report an Incident',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.newIncidentScreen,
                          );
                        },
                      ),
                      buildMenuItem(
                        context,
                        'Off Duty',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.homeScreen,
                          );
                        },
                      ),
                      buildMenuItem(
                        context,
                        'Support',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.homeScreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: buildMenuItem(
                    context,
                    'Logout',
                    () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginScreen);
                      Provider.of<Auth>(
                        context,
                        listen: false,
                      ).logout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }

  static Future showVehicalDeallocationDialogue(
      BuildContext context, String id, String plateNumber) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Vehicle Deallocation'),
            content: Container(
              width: double.infinity,
              height: 100,
              child: Column(children: [
                Text('Dispatcher requested to deallocate the vehicle'),
                SizedBox(
                  height: 10,
                ),
                Text(plateNumber),
              ]),
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Proceed'),
                ),
              ),
            ],
          );
        });
  }

  static Future showMeterReadingDialogue(
      BuildContext context, String id, String plateNumber) {
    TextEditingController _meterReadingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Enter ODO meter reading'),
            content: Container(
              width: double.infinity,
              height: 100,
              child: Column(children: [
                Text(plateNumber),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    filled: true,
                    fillColor: Constants.textFieldFillColor,
                    focusColor: Constants.textFieldFillColor,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                  controller: _meterReadingController,
                  keyboardType: TextInputType.number,
                ),
                // Text('Error'),
              ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final meterReading = int.tryParse(
                    _meterReadingController.text.toString(),
                  );

                  if (meterReading == null) {
                    return;
                  }

                  final response = await Provider.of<VehicalProvider>(
                    context,
                    listen: false,
                  ).updateVehicalOdoMeter(
                    DeallocateVehicalModel(
                      id,
                      meterReading,
                    ),
                  );

                  if (response.hasError == null || response.hasError) {
                    return;
                  }
                  Navigator.of(ctx).pop();
                },
                child: Text('Save'),
              )
            ],
          );
        });
  }
}
