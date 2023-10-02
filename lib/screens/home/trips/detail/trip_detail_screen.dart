import 'package:flutter/material.dart';
import 'package:motorpool/providers/trip_provider.dart';
import 'package:motorpool/widgets/home/trips/detail/trip_detail_widget.dart';
import 'package:provider/provider.dart';

import '../../../loading_screen.dart';

class TripDetailScreen extends StatefulWidget {
  final String _id;

  TripDetailScreen(
    this._id,
  );

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Info'),
      ),
      body: FutureBuilder(
          future: Provider.of<TripProvider>(context, listen: false)
              .populateTrip(widget._id),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Consumer<TripProvider>(
                builder: (ctx, provider, _) {
                  return provider.tripDetail != null
                      ? TripDetailWidget(provider.tripDetail)
                      : Center(
                          child: Text("no trip found"),
                        );
                },
              ),
            );
          }),
    );
  }
}
