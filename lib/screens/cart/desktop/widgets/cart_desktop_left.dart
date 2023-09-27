import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/providers/cart_provider.dart';
import './cart_destop_cart_items.dart';

class CartDesktopLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.colorPurpleDark,
                    ),
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text('Item'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('Qty.'),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Total',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: CartDesktopCartItems(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'GRAND TOTAL',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Consumer<CartProvider>(
                        builder: (ctx, cart, _) =>
                            Text('RS. ${cart.grandTotal.toStringAsFixed(2)}')),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              child: Text(
                'CHECKOUT',
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 30,
                  fontFamily: Constants.fontFamilyRoboto,
                ),
              ),
              onPressed: () {},
              color: Constants.colorYellow,
            ),
          )
        ],
      ),
    );
  }
}
