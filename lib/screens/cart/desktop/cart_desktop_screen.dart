import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/screens/loading_screen.dart';

import '../../../helpers/common/constants.dart';
import '../../../providers/cart_provider.dart';

import './widgets/cart_desktop_left.dart';
import './widgets/cart_desktop_right.dart';

class CartDesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.colorLightGrey,
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: Constants.fontFamilyRoboto,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Constants.textColor1,
          ),
          child: FutureBuilder(
              future: Provider.of<CartProvider>(context, listen: false)
                  .populateProducts(),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                return Container(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: CartDesktopLeft(),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: CartDesktopRight(),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
