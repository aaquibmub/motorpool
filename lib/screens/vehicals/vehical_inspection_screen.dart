import 'package:flutter/material.dart';
import 'package:motorpool/providers/vehical_provider.dart';
import 'package:motorpool/screens/vehicals/vehical_inspection_body_screen.dart';
import 'package:motorpool/screens/vehicals/vehical_inspection_fuel_screen.dart';
import 'package:motorpool/screens/vehicals/vehical_inspection_general_screen.dart';
import 'package:provider/provider.dart';

import '../loading_screen.dart';

class VehicalInspectionScreen extends StatefulWidget {
  final String _vehicalId;

  VehicalInspectionScreen(
    this._vehicalId,
  );

  @override
  _VehicalInspectionScreenState createState() =>
      _VehicalInspectionScreenState();
}

class _VehicalInspectionScreenState extends State<VehicalInspectionScreen> {
  // _updateState() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<VehicalProvider>(context, listen: false)
          .createInspection(widget._vehicalId),
      builder: (ctx, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        return DefaultTabController(
          length: 3,
          // initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Inspection'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: 'GENERAL',
                  ),
                  Tab(
                    text: 'BODY',
                  ),
                  Tab(
                    text: 'Fuel',
                  ),
                ],
              ),
            ),
            body: Consumer<VehicalProvider>(builder: (ctx, provider, _) {
              return provider.inspectionResponseModel != null &&
                      !provider.inspectionResponseModel.hasError
                  ? Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              VehicalInspectionGeneralScreen(
                                provider.inspectionResponseModel.result,
                                // _updateState,
                              ),
                              VehicalInspectionBodyScreen(
                                provider.inspectionResponseModel.result,
                              ),
                              VehicalInspectionFuelScreen(
                                  provider.inspectionResponseModel.result)
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(provider.inspectionResponseModel != null
                          ? provider.inspectionResponseModel.msg
                          : 'loading..'),
                    );
            }),
          ),
        );
      },
    );
  }
}
