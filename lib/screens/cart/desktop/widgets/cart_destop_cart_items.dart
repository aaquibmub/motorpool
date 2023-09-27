import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/providers/cart_provider.dart';

class CartDesktopCartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, provider, _) {
        return ListView.builder(
          itemCount: provider.cartItems.length,
          itemBuilder: (_a, i) {
            return DefaultTextStyle(
              style: TextStyle(
                fontSize: 16,
                color: Constants.colorPurpleDark,
              ),
              child: InkWell(
                onTap: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .updateSelectedCartItem(provider.cartItems[i]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: provider.isCartItemSelected(provider.cartItems[i].id)
                        ? Colors.white30
                        : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(provider.cartItems[i].description),
                      ),
                      Expanded(
                        flex: 1,
                        child:
                            Text(provider.cartItems[i].qty.toStringAsFixed(1)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${(provider.cartItems[i].qty * provider.cartItems[i].unitPrice).toStringAsFixed(2)}',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
