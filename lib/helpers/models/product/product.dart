import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String itemID;
  final String dealID;
  final String categoryId;
  final int type;
  final String name;
  final String itemNoStr;
  final String companyMake;
  final String locQuan;
  final String batchID;
  final String image;
  final String image1;
  final String description;
  final double salePrice;
  final double wholeSalePrice;
  final double orderPrice;
  final double specialSalePrice;
  final double purchaseCost;
  final String fkUnitGroupID;
  final String fkUnitID;
  final String previousPrices;
  final String fkItemVariantID;
  final bool underAgeCheck;
  final bool allowedDiscount;
  final double discount;
  final bool isTaxable;
  final double taxRate;
  final double taxRatePurchase;

  Product(
    this.itemID,
    this.dealID,
    this.type,
    this.categoryId,
    this.name,
    this.itemNoStr,
    this.companyMake,
    this.locQuan,
    this.batchID,
    this.image,
    this.image1,
    this.description,
    this.salePrice,
    this.wholeSalePrice,
    this.orderPrice,
    this.specialSalePrice,
    this.purchaseCost,
    this.fkUnitGroupID,
    this.fkUnitID,
    this.previousPrices,
    this.fkItemVariantID,
    this.underAgeCheck,
    this.allowedDiscount,
    this.discount,
    this.isTaxable,
    this.taxRate,
    this.taxRatePurchase,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
