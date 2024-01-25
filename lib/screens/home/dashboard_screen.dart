import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/screens/home/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/custom_icons.dart';
import '../../helpers/common/routes.dart';
import '../../helpers/models/user.dart';
import '../../providers/auth.dart';
import '../../providers/dashboard_provider.dart';
import '../loading_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User _currentuser = Provider.of<Auth>(context).currentUser;

    EdgeInsets getMargin() {
      return EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      );
    }

    EdgeInsets getPadding() {
      return EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      );
    }

    BoxDecoration getBoxDecoration() {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Constants.colorCardBorder,
        ),
      );
    }

    Widget getContainer(
      IconData iconData,
      String title,
      Widget subtitle,
      Function onTap,
    ) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: getPadding(),
          decoration: getBoxDecoration(),
          margin: getMargin(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 10,
                ),
                width: 50,
                child: Icon(
                  iconData,
                  color: Constants.primaryColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                    ),
                  ),
                  Container(
                    child: subtitle,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _currentuser.firstName + ' ' + _currentuser.lastName,
          ),
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: FutureBuilder(
          future: Provider.of<DashboardProvider>(context, listen: false)
              .populateDashboardModel(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return Consumer<DashboardProvider>(builder: (ctx, provider, _) {
              return provider.dashboardModel != null
                  ? Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 30,
                            ),
                            getContainer(
                              MyFlutterApp.ico_vehicle,
                              'Vehicle',
                              Text(
                                provider.dashboardModel.assignedVehical != null
                                    ? provider.dashboardModel.assignedVehical
                                    : 'No Vehicle assigned',
                              ),
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(2),
                                  ),
                                )
                              },
                            ),
                            getContainer(
                              MyFlutterApp.ico_trip,
                              'Ongoing Trip',
                              Text(
                                provider.dashboardModel.ongoingTrips.toString(),
                              ),
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(1),
                                  ),
                                )
                              },
                            ),
                            getContainer(
                              MyFlutterApp.ico_badge_trip,
                              'Assigned Trips',
                              Text(
                                provider.dashboardModel.assignedTrips
                                    .toString(),
                              ),
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TabsScreen(1),
                                  ),
                                )
                              },
                            ),
                            if (_currentuser.vehicals != null &&
                                _currentuser.vehicals.length > 0)
                              getContainer(
                                MyFlutterApp.ico_vehicle_inspection,
                                'Pending Inspection',
                                Text(
                                  provider.dashboardModel.inspectionPending
                                      .toString(),
                                ),
                                () => {
                                  Utility.showVehiclesForInspectionDialogue(
                                    context,
                                    _currentuser.vehicals,
                                  ).then((value) {})
                                },
                              ),
                            getContainer(
                              MyFlutterApp.ico_vehicle,
                              'Issues Reported',
                              Text(
                                provider.dashboardModel.issuesReported
                                    .toString(),
                              ),
                              () => {
                                Navigator.of(context).pushReplacementNamed(
                                    Routes.newIncidentScreen)
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No data'),
                    );
            });
          }),
    );
  }
}
