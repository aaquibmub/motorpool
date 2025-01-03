import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/routes.dart';
import 'package:motorpool/helpers/models/common/dropdown_item.dart';
import 'package:motorpool/helpers/models/common/response_model.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_enroute.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/auth.dart';
import '../../providers/vehical_provider.dart';
import '../../screens/vehicals/vehical_inspection_screen.dart';
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

  static Future notificationAlert(
      BuildContext context, String title, String msg) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? "Notification!"),
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

    if (status == TripStatus.BackToMotorPool
        //  ||status == TripStatus.OdoMeterAtCancel
        ) {
      return null;
    }

    if (status == TripStatus.Cancelled) {
      return TripStatus.BackToMotorPool;
    }

    // if (status == TripStatus.OdoMeterAtEnd) {
    //   return TripStatus.Completed;
    // }

    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      if (status == TripStatus.Updated) {
        return null;
      }
      return TripStatus.Completed;
    }

    if (status == TripStatus.TripStarted) {
      return TripStatus.VehicalDispatched;
    }

    // if (status == TripStatus.OdoMeterAtStart) {
    //   return TripStatus.VehicalDispatched;
    // }

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
    if (status == TripStatus.WaitingForStopActivity) {
      return TripStatus.TripResumedAfterStop;
    }
    if (status == TripStatus.ArrivedAtAddress) {
      return TripStatus.WaitingForAddressActivity;
    }
    if (status == TripStatus.WaitingForAddressActivity) {
      return TripStatus.TripResumedAfterAddress;
    }
    final destinationType = nextDestination.destinationType.value;
    if (destinationType == DestinationType.Pickup) {
      return TripStatus.ArrivedAtPickupLocation;
    } else if (destinationType == DestinationType.Stop) {
      return TripStatus.ArrivedAtStop;
    } else if (destinationType == DestinationType.Address) {
      return TripStatus.ArrivedAtAddress;
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

    // if (status == TripStatus.OdoMeterAtEnd) {
    //   return "END TRIP";
    // }

    if (status == TripStatus.Completed) {
      return "Back to Motorpool";
    }

    final nextDestination = _tripEnroute.items[_tripEnroute.items.length - 1];
    final endTrip = nextDestination.completed;

    if (endTrip) {
      return "COMPLETE";
    }

    if (status == TripStatus.TripStarted) {
      return "DISPATCH";
    }
    if (status == TripStatus.VehicalDispatched) {
      return "ARRIVED AT PICKUP";
    }
    if (status == TripStatus.ArrivedAtPickupLocation ||
        status == TripStatus.ArrivedAtStop ||
        status == TripStatus.ArrivedAtAddress) {
      return "RESUME TRIP";
    }
    if (status == TripStatus.WaitingForPassenger) {
      return "PASSENGER ON BOARDED";
    }
    if (status == TripStatus.WaitingForStopActivity) {
      return "RESUME TRIP";
    }
    if (status == TripStatus.WaitingForAddressActivity) {
      return "RESUME TRIP";
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

    void _handleOnDutyLink(BuildContext ctx) async {
      final currentUser =
          await Provider.of<Auth>(ctx, listen: false).refreshUserData();
      final onDuty = currentUser.onDuty != null && currentUser.onDuty;
      if (!onDuty) {
        Provider.of<Auth>(ctx, listen: false)
            .updateDuty(
          currentUser.id,
          !onDuty,
        )
            .then((value) {
          // setst
        });
      } else {
        final vehicalAllocated =
            currentUser.vehicals != null && currentUser.vehicals.length > 0;
        if (vehicalAllocated) {
          Utility.showVehicalDeallocationByDriverDialogue(
            ctx,
            currentUser.id,
            currentUser.vehicals[0],
          ).then((value) async {
            Navigator.of(ctx).pop();
            await _handleOnDutyLink(ctx);
          });
        } else {
          Provider.of<Auth>(context, listen: false)
              .updateDuty(
            currentUser.id,
            !onDuty,
          )
              .then((value) {
            // setst
          });
        }
      }
    }

    void _handleBackToMotorpoolLink(BuildContext ctx) async {
      var currentUser = Provider.of<Auth>(ctx, listen: false).currentUser;
      Utility.showBackToMotorpoolMeterReadingDialogue(
        ctx,
        currentUser.id,
      ).then((msg) async {
        showErrorDialogue(ctx, msg, 'Back to Motorpool');
      });
    }

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
                  // Hello
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
                  // Name
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
                  // Status
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
                          (_currentuser.onDuty != null && _currentuser.onDuty
                                  ? 'On Duty'
                                  : 'Off Duty')
                              .toUpperCase(),
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
                      // Home
                      buildMenuItem(
                        context,
                        'Home',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.homeScreen,
                          );
                        },
                      ),
                      // Report an Incident
                      buildMenuItem(
                        context,
                        'Report an Incident',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.newIncidentScreen,
                          );
                        },
                      ),
                      // Off/On Duty
                      buildMenuItem(
                        context,
                        _currentuser.onDuty != null && _currentuser.onDuty
                            ? 'Off Duty'
                            : 'On Duty',
                        () async => await _handleOnDutyLink(context),
                      ),
                      // Back to Motorpool
                      buildMenuItem(
                        context,
                        'Back to Motorpool',
                        () async => await _handleBackToMotorpoolLink(context),
                      ),
                      // Support
                      buildMenuItem(
                        context,
                        'Support',
                        () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.supportScreen,
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

  static Future<ResponseModel<String>> showVehicalDeallocationByDriverDialogue(
    BuildContext context,
    String driverId,
    DropdownItem<String> vehical,
  ) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Vehicle Deallocation'),
            content: Container(
              width: double.infinity,
              height: 100,
              child: Column(children: [
                Text(vehical.text),
              ]),
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () async {
                    await Utility.showMeterReadingAndDeallocateDialogue(
                      context,
                      driverId,
                      vehical.value,
                      vehical.text,
                    ).then((value1) {
                      Navigator.of(ctx).pop();
                    });
                  },
                  child: Text('Deallocate'),
                ),
              ),
            ],
          );
        });
  }

  static Future showMeterReadingAndDeallocateDialogue(
      BuildContext context, String id, String vehicleId, String plateNumber) {
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
                  ).deallocate(id, vehicleId, meterReading);

                  if (response.hasError == null || response.hasError) {
                    Utility.showErrorDialogue(
                      context,
                      response.msg,
                    );
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
                  final param = DeallocateVehicalModel(
                    id,
                    meterReading,
                  );
                  final response = await Provider.of<VehicalProvider>(
                    ctx,
                    listen: false,
                  ).updateVehicalOdoMeter(param);

                  if (response.hasError == null || response.hasError) {
                    Utility.showErrorDialogue(
                      context,
                      response.msg,
                    );
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

  static Future showVehiclesForInspectionDialogue(
    BuildContext context,
    List<DropdownItem<String>> vehicles,
  ) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Allocated Vehicles'),
            content: Container(
              width: double.infinity,
              height: 100,
              child: Column(children: [
                ...vehicles.map(
                  (v) => InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          Text(v.text),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicalInspectionScreen(v.value),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }

  static Future showBackToMotorpoolMeterReadingDialogue(
    BuildContext context,
    String userId,
  ) {
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

                  final response =
                      await Provider.of<TripProvider>(ctx, listen: false)
                          .backToMotorpool(userId, meterReading);

                  var msg = "Operation Successfull";
                  if (response != "" && response != null) {
                    msg = response;
                  }
                  Navigator.of(context).pop(msg);
                },
                child: Text('DONE'),
              )
            ],
          );
        });
  }

  static void showErrorDialogue(BuildContext context, String message,
      [String title]) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title ?? 'An error occured'),
            content: Text(message),
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

  static Future<void> makePhoneCall(String phoneNumber) async {
    await launch("tel://$phoneNumber");
  }

  static Color getColorFromHex(String hexColor) {
    return hexColor != null
        ? Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0x80000000)
        : Colors.black;
  }
}
