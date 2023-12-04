import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/utility.dart';
import '../../providers/vehical_provider.dart';
import '../../widgets/home/vehicals/vehical_inspection_history_card_widget.dart';
import '../loading_screen.dart';

class VehicalInspectionListScreen extends StatefulWidget {
  const VehicalInspectionListScreen({Key key}) : super(key: key);

  @override
  State<VehicalInspectionListScreen> createState() =>
      _VehicalInspectionListScreenState();
}

class _VehicalInspectionListScreenState
    extends State<VehicalInspectionListScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehical Inspections'),
      ),
      drawer: Utility.buildDrawer(context),
      body: Center(
        child: FutureBuilder(
            future: Provider.of<VehicalProvider>(context, listen: false)
                .populateVehicalInspectionHistory(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              }
              return Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Consumer<VehicalProvider>(
                  builder: (ctx, provider, _) {
                    return provider.vehicalInspectionHistory.length > 0
                        ? ListView.builder(
                            itemCount: provider.vehicalInspectionHistory.length,
                            itemBuilder: (_a, i) {
                              return VehicalInspectionHistoryCardWidget(
                                provider.vehicalInspectionHistory[i],
                              );
                            },
                          )
                        : Center(
                            child: Text("no vehical inspected so far"),
                          );
                  },
                ),
              );
            }),
      ),
    );
  }
}
