import 'package:flutter/material.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:motorpool/widgets/home/vehicals/vehical_history_card_widget.dart';
import 'package:provider/provider.dart';

import '../loading_screen.dart';

class VehicalsScreen extends StatefulWidget {
  @override
  _VehicalsScreenState createState() => _VehicalsScreenState();
}

class _VehicalsScreenState extends State<VehicalsScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Vehical History'),
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: Provider.of<VehicalProvider>(context, listen: false)
                .populateVehicalHistory(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              return Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Consumer<VehicalProvider>(
                  builder: (ctx, provider, _) {
                    return provider.vehicalHistory.length > 0
                        ? ListView.builder(
                            itemCount: provider.vehicalHistory.length,
                            itemBuilder: (_a, i) {
                              return VehicalHistoryCardWidget(
                                  provider.vehicalHistory[i]);
                            },
                          )
                        : Center(
                            child: Text("no vehical assigned so far"),
                          );
                  },
                ),
              );
            }),
      ),
    );
  }
}
