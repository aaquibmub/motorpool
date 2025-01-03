import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/shared_types.dart';
import 'package:motorpool/helpers/common/utility.dart';
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
                    AddressCardWidget(
                      "TRIP TYPE",
                      _tripDetail.type,
                      '',
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
                    ..._tripDetail.addresses.map((t) {
                      return AddressCardWidget(
                        "ADDRESS",
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
                      _tripDetail.vehical?.registrationPlate,
                      '',
                    ),
                    ..._tripDetail.specialServices.map((t) {
                      return AddressCardWidget(
                        t.qty.toString() + " " + t.name,
                        "",
                        "",
                      );
                    }).toList(),
                    AddressCardWidget(
                      "Notes",
                      _tripDetail.notes,
                      "",
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Constants.colorGreen,
                ),
              ),
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
                  if (response.hasError) {
                    if (response.errorAction ==
                        ResponseErrorAction.UpdateVehicleOdometer) {
                      Utility.showMeterReadingDialogue(
                        context,
                        response.id,
                        response.label,
                      ).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripEnrouteScreen(
                                    _tripDetail.id,
                                  )),
                        );
                      });
                    } else {
                      Utility.showErrorDialogue(
                        context,
                        response.msg,
                      );
                    }
                    return;
                  }
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
                style: Theme.of(context).primaryTextTheme.labelLarge,
              ),
              // elevation: 0,
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
