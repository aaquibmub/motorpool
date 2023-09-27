import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/providers/cart_provider.dart';

import '../../../../helpers/common/constants.dart';
import '../../../../helpers/common/routes.dart';
import '../../../../helpers/common/utility.dart';

import './cart_desktop_search_products.dart';

class CartDesktopRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    Widget buildTimeContainer() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 30,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '7:00 AM',
                  style: TextStyle(
                    fontFamily: Constants.fontFamilyMontserrat,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor1,
                  ),
                ),
                Text(
                  'MONDAY, 27 NOV 2020',
                  style: TextStyle(
                    fontFamily: Constants.fontFamilyMontserrat,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildAction(
      String title,
      IconData icon,
      Function action,
      bool selected,
    ) {
      return selected
          ? Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(top: 15),
              width:
                  (Utility.getValuebyDeviceSize(deviceSize, 30.0, 50.0, 100.0)
                      as double),
              decoration: BoxDecoration(
                color: Constants.colorPurpleDark,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Center(
                      child: Icon(
                        icon,
                        size: (Utility.getValuebyDeviceSize(
                            deviceSize, 18.0, 32.0, 42.0) as double),
                        color: Constants.colorYellow,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Constants.colorPurpleDark,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: (Utility.getValuebyDeviceSize(
                            deviceSize, 8.0, 8.0, 10.0) as double),
                        fontWeight: FontWeight.normal,
                        color: Constants.colorYellow,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: action,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(top: 15),
                // height: (Utility.getValuebyDeviceSize(deviceSize, 30.0, 50.0, 100.0)
                //     as double),
                width:
                    (Utility.getValuebyDeviceSize(deviceSize, 30.0, 50.0, 100.0)
                        as double),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Center(
                        child: Icon(
                          icon,
                          size: (Utility.getValuebyDeviceSize(
                              deviceSize, 18.0, 32.0, 42.0) as double),
                          color: Constants.colorPurpleDark,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: (Utility.getValuebyDeviceSize(
                              deviceSize, 8.0, 8.0, 10.0) as double),
                          fontWeight: FontWeight.normal,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    }

    Widget buildActions() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAction(
                  'HOME',
                  Icons.home,
                  () {
                    if (Utility.isMonitor(deviceSize)) {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.homeScreen);
                    }
                  },
                  false,
                ),
                buildAction(
                  'PRODUCTS',
                  Icons.inventory,
                  () {
                    Utility.toBeImplemented(context);
                  },
                  cartProvider.showProducts,
                ),
              ],
            ),
            Row(
              children: [
                buildAction(
                  'PARKED CARTS',
                  Icons.add_shopping_cart,
                  () {
                    Utility.toBeImplemented(context);
                  },
                  false,
                ),
              ],
            ),
            Row(
              children: [
                buildAction(
                  'DROP CART',
                  Icons.remove_shopping_cart,
                  () {
                    Utility.toBeImplemented(context);
                  },
                  false,
                ),
              ],
            ),
          ],
        ),
      );
    }

    void numpadButtonAction(String value) {
      Provider.of<CartProvider>(context, listen: false)
          .updateNumpadValue(value);
    }

    Widget buildNumPadAction(
        Widget title, Color backgroundColor, String value) {
      return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => numpadButtonAction(value),
          child: Container(
            // padding: EdgeInsets.all(100),
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Center(
              child: DefaultTextStyle(
                child: title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildNumPad() {
      Widget buildTextField() {
        var provider = Provider.of<CartProvider>(context);
        var controller = TextEditingController();
        controller.value = TextEditingValue(
            text:
                '${provider.numpadAmount == null ? '' : provider.numpadAmount}');
        return TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
          ),
          controller: controller,
          readOnly: true,
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: buildTextField(),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        child: Icon(Icons.backspace),
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .updateNumpadValue('backspace');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildNumPadAction(
                              Text('1'), Constants.textColor1, '1'),
                          buildNumPadAction(
                              Text('2'), Constants.textColor1, '2'),
                          buildNumPadAction(
                              Text('3'), Constants.textColor1, '3'),
                          buildNumPadAction(
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                              Constants.colorGrey,
                              'up'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildNumPadAction(
                              Text('4'), Constants.textColor1, '4'),
                          buildNumPadAction(
                              Text('5'), Constants.textColor1, '5'),
                          buildNumPadAction(
                              Text('6'), Constants.textColor1, '6'),
                          buildNumPadAction(
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              Constants.colorGrey,
                              'down'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildNumPadAction(
                              Text('7'), Constants.textColor1, '7'),
                          buildNumPadAction(
                              Text('8'), Constants.textColor1, '8'),
                          buildNumPadAction(
                              Text('9'), Constants.textColor1, '9'),
                          buildNumPadAction(
                              Icon(
                                Icons.highlight_remove,
                                color: Colors.white,
                              ),
                              Colors.red,
                              'delete'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildNumPadAction(
                              Text('0'), Constants.textColor1, '0'),
                          buildNumPadAction(
                              Text('.'), Constants.textColor1, '.'),
                          buildNumPadAction(
                              Text('00'), Constants.textColor1, '00'),
                          buildNumPadAction(
                              Text('OK'), Constants.colorGreen, 'ok'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Column(
      children: [
        buildTimeContainer(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: buildActions(),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: buildNumPad(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: cartProvider.showProducts
                      ? CartDesktopSearchProducts()
                      : Text('Please select action'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
