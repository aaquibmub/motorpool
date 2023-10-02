import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/enroute/trip_enroute_item_widget.dart';
import 'package:motorpool/widgets/home/trips/trip_summary_widget.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Enroute'),
      ),
      body: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateTripEnroute(widget._id),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: InkWell(
                                onTap: () => {},
                                child: Icon(Icons.access_alarm),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () => {},
                                child: Icon(Icons.access_alarm),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: provider.tripEnroute != null
                              ? Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TripSummaryWiget(
                                        provider.tripEnroute.tripRoute,
                                        provider.tripEnroute.tripDestination,
                                        provider.tripEnroute.numberOfLocations,
                                        provider.tripEnroute.numberOfPassengers,
                                      ),
                                      provider.tripEnroute.items.length > 0
                                          ? Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ...provider.tripEnroute.items
                                                      .map((i) =>
                                                          TripEnrouteItemWidget(
                                                              i))
                                                      .toList(),
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: Text("no trip found"),
                                            )
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Text("no trip found"),
                                ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: RaisedButton(
                          color: Constants.colorGreen,
                          onPressed: () {
                            Provider.of<TripProvider>(context, listen: false)
                                .updateStatus(
                              TripStatusUpdate(
                                provider.tripEnroute.tripId,
                                TripStatus.VehicalDispatched,
                                '',
                              ),
                            )
                                .then((response) {
                              setState(() {});
                            });
                          },
                          child: Text(
                            'DISPATCH',
                            style: Theme.of(context).primaryTextTheme.button,
                          ),
                          elevation: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}
