import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/utility.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Utility.buildDrawer(context),
      body: Container(
        child: Center(child: Text('Dashboard')),
      ),
    );
  }
}
