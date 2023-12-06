import 'package:flutter/material.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/custom_icons.dart';
import '../../helpers/common/utility.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final String motorPool = '0114238994';
    final String trafic = '993';
    final String police = '999';
    final String ambulance = '997';
    final String emergency = '911';
    final String najam = '920000560';
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
        vertical: 20,
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
      String title,
      String arabicTitle,
      String subtitle,
      Function onTap,
    ) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: deviceSize.width,
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
                  MyFlutterApp.telephone_ico,
                  color: Constants.primaryColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: deviceSize.width - 130,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                          ),
                          Expanded(
                            child: Text(
                              arabicTitle,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 8,
                    ),
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
                'Motor Pool',
                'کنٹرول',
                motorPool,
                () async => {
                  await Utility.makePhoneCall(
                    motorPool,
                  )
                },
              ),
              getContainer(
                'Traffic Accidents',
                'حوادث المرور',
                trafic,
                () async => {
                  await Utility.makePhoneCall(
                    trafic,
                  )
                },
              ),
              getContainer(
                'Police',
                'شرطة',
                police,
                () async => {
                  await Utility.makePhoneCall(
                    police,
                  )
                },
              ),
              getContainer(
                'Ambulance',
                'سياره اسعاف',
                ambulance,
                () async => {
                  await Utility.makePhoneCall(
                    ambulance,
                  )
                },
              ),
              getContainer(
                'Unified Emergency Number',
                'رقم الطوارئ الموحد',
                emergency,
                () async => {
                  await Utility.makePhoneCall(
                    emergency,
                  )
                },
              ),
              getContainer(
                'Najm',
                'نجم',
                najam,
                () async => {
                  await Utility.makePhoneCall(
                    najam,
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
