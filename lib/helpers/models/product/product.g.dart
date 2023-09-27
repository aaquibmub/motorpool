// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['itemID'] as String,
    json['dealID'] as String,
    json['type'] as int,
    json['categoryId'] as String,
    json['name'] as String,
    json['itemNoStr'] as String,
    json['companyMake'] as String,
    json['locQuan'] as String,
    json['batchID'] as String,
    json['image'] as String,
    json['image1'] as String,
    json['description'] as String,
    (json['salePrice'] as num)?.toDouble(),
    (json['wholeSalePrice'] as num)?.toDouble(),
    (json['orderPrice'] as num)?.toDouble(),
    (json['specialSalePrice'] as num)?.toDouble(),
    (json['purchaseCost'] as num)?.toDouble(),
    json['fkUnitGroupID'] as String,
    json['fkUnitID'] as String,
    json['previousPrices'] as String,
    json['fkItemVariantID'] as String,
    json['underAgeCheck'] as bool,
    json['allowedDiscount'] as bool,
    (json['discount'] as num)?.toDouble(),
    json['isTaxable'] as bool,
    (json['taxRate'] as num)?.toDouble(),
    (json['taxRatePurchase'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'itemID': instance.itemID,
      'dealID': instance.dealID,
      'categoryId': instance.categoryId,
      'type': instance.type,
      'name': instance.name,
      'itemNoStr': instance.itemNoStr,
      'companyMake': instance.companyMake,
      'locQuan': instance.locQuan,
      'batchID': instance.batchID,
      'image': instance.image,
      'image1': instance.image1,
      'description': instance.description,
      'salePrice': instance.salePrice,
      'wholeSalePrice': instance.wholeSalePrice,
      'orderPrice': instance.orderPrice,
      'specialSalePrice': instance.specialSalePrice,
      'purchaseCost': instance.purchaseCost,
      'fkUnitGroupID': instance.fkUnitGroupID,
      'fkUnitID': instance.fkUnitID,
      'previousPrices': instance.previousPrices,
      'fkItemVariantID': instance.fkItemVariantID,
      'underAgeCheck': instance.underAgeCheck,
      'allowedDiscount': instance.allowedDiscount,
      'discount': instance.discount,
      'isTaxable': instance.isTaxable,
      'taxRate': instance.taxRate,
      'taxRatePurchase': instance.taxRatePurchase,
    };
