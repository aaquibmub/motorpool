import 'package:flutter/material.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/custom_icons.dart';
import '../../helpers/common/utility.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String motorPool = '0114238994';
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
      String subtitle,
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
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
            'Support',
          ),
        ),
      ),
      drawer: Utility.buildDrawer(context),
      body: Container(
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
                'Motor Pool',
                motorPool,
                () async => {
                  await Utility.makePhoneCall(
                    motorPool,
                  )
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
