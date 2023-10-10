import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/models/trips/detail/trip_detail.dart';
import 'package:motorpool/helpers/models/trips/enroute/trip_status_update.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/screens/home/trips/enroute/trip_enroute_screen.dart';
import 'package:motorpool/widgets/common/address_card_widget.dart';
import 'package:provider/provider.dart';

class TripDetailWidget extends StatelessWidget {
  final TripDetail _tripDetail;

  TripDetailWidget(
    this._tripDetail,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Text(
                        "Trip Info",
                      ),
                    ),
                    ..._tripDetail.pickups.map((t) {
                      return AddressCardWidget(
                        "PICKUP LOCATION",
                        t.address.text,
                        "",
                      );
                    }).toList(),
                    ..._tripDetail.stops.map((t) {
                      return AddressCardWidget(
                        "STOP",
                        t.address.text,
                        "",
                      );
                    }).toList(),
                    ..._tripDetail.dropoffs.map((t) {
                      return AddressCardWidget(
                        "DROPOFF",
                        t.address.text,
                        "",
                      );
                    }).toList(),
                    AddressCardWidget(
                      "VEHICAL",
                      _tripDetail.vehical?.make,
                      _tripDetail.vehical?.model,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: RaisedButton(
              color: Constants.colorGreen,
              onPressed: () => {
                Provider.of<TripProvider>(context, listen: false)
                    .updateStatus(
                  TripStatusUpdate(
                    _tripDetail.id,
                    TripStatus.TripStarted,
                    null,
                    null,
                    '',
                  ),
                )
                    .then((response) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripEnrouteScreen(
                              _tripDetail.id,
                            )),
                  );
                })
              },
              child: Text(
                'START',
                style: Theme.of(context).primaryTextTheme.button,
              ),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
