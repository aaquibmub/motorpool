import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_enroute_widget.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_waiting_for_passsenger_widget.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../helpers/common/utility.dart';
import '../../../../widgets/home/trips/enroute/trip_done_widget.dart';
import '../../../../widgets/home/trips/enroute/trip_odo_meter_widget.dart';
import '../../../loading_screen.dart';

class TripEnrouteScreen extends StatefulWidget {
  final String _id;

  TripEnrouteScreen(
    this._id,
  );
  @override
  State<TripEnrouteScreen> createState() => _TripEnrouteScreenState();
}

class _TripEnrouteScreenState extends State<TripEnrouteScreen> {
  Future<void> fetchAndSetFuture;
  // _updateState() {
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    fetchAndSetFuture = Provider.of<TripProvider>(
      context,
      listen: false,
    ).populateTripEnroute(widget._id);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Center(child: Text('Trip Enroute')),
      ),
      body: FutureBuilder(
          future: fetchAndSetFuture,
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  final currentStatus = provider.tripEnroute.tripStatus;

                  final nextTripStatus = Utility.getNextTripStatus(
                    provider.tripEnroute,
                  );

                  return (currentStatus == TripStatus.WaitingForPassenger ||
                          currentStatus == TripStatus.WaitingForStopActivity ||
                          currentStatus == TripStatus.WaitingForAddressActivity)
                      ? TripWaitingForPassengerWidget(
                          provider.tripEnroute,
                          // _updateState,
                        )
                      : currentStatus == TripStatus.TripStarted ||
                              nextTripStatus == TripStatus.OdoMeterAtEnd ||
                              nextTripStatus == TripStatus.OdoMeterAtCancel
                          ? TripOdoMeterWidget(
                              provider.tripEnroute,
                              currentStatus,
                              nextTripStatus,
                            )
                          : currentStatus == TripStatus.Completed ||
                                  currentStatus == TripStatus.OdoMeterAtCancel
                              ? TripDoneWidget(provider.tripEnroute)
                              : TripEnrouteWidget(
                                  provider.tripEnroute,
                                  // _updateState,
                                );
                },
              ),
            );
          }),
    );
  }
}
