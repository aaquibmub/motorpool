import 'package:flutter_guid/flutter_guid.dart';

class CartItem {
  final Guid id;
  int index;
  final String productId;
  final String productVarId;
  final String description;
  double qty;
  double basePrice;
  double unitPrice;

  bool allowedDiscount;
  double discountAllowed;
  double discount;

  bool isTaxable;
  double taxRate;
  double tax;
  String deaID;
  String unitID;
  double total;

  CartItem(
    this.id,
    this.description,
    this.productId,
    this.productVarId,
    this.qty,
    this.basePrice,
    this.unitPrice,
    this.allowedDiscount,
    this.discountAllowed,
    this.discount,
    this.isTaxable,
    this.taxRate,
    this.tax,
    this.deaID,
    this.unitID,
    this.total,
  );
}
