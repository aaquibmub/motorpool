import 'package:flutter/material.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:motorpool/widgets/home/vehicals/vehical_history_card_widget.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/utility.dart';
import '../../providers/auth.dart';
import '../loading_screen.dart';

class VehicalsScreen extends StatefulWidget {
  @override
  _VehicalsScreenState createState() => _VehicalsScreenState();
}

class _VehicalsScreenState extends State<VehicalsScreen> {
  _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicals'),
      ),
      drawer: Utility.buildDrawer(context),
      body: Center(
        child: FutureBuilder(
            future: Provider.of<Auth>(context, listen: false).refreshUserData(),
            builder: (cuCtx, cuSnapshot) {
              if (cuSnapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              return FutureBuilder(
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
                              ? Consumer<Auth>(builder: (cuCtx, cuProvider, _) {
                                  return ListView.builder(
                                    itemCount: provider.vehicalHistory.length,
                                    itemBuilder: (_a, i) {
                                      return VehicalHistoryCardWidget(
                                        provider.vehicalHistory[i],
                                        cuProvider.currentUser,
                                        _updateState,
                                      );
                                    },
                                  );
                                })
                              : Center(
                                  child: Text("no vehical assigned so far"),
                                );
                        },
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
