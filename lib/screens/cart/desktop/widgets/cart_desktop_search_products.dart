import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/providers/cart_provider.dart';

import '../../../../helpers/common/constants.dart';

import './cart_desktop_categories.dart';

class CartDesktopSearchProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 40,
        left: 10,
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Constants.colorGrey),
              ),
              child: TextField(
                onChanged: (value) => Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).filterCategories(value),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // contentPadding: EdgeInsets.all(10),
                  hintText: 'SEARCH CATEGORY, PRODUCT, SKU OR BARCODE',
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CartDesktopCategories(),
          ),
        ],
      ),
    );
  }
}
