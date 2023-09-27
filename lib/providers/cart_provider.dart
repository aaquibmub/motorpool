import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:http/http.dart' as http;
import 'package:motorpool/helpers/common/constants.dart';

import 'package:motorpool/helpers/models/cart/cart_item.dart';
import 'package:motorpool/helpers/models/product/category.dart';
import 'package:motorpool/helpers/models/product/product.dart';
import 'package:motorpool/helpers/models/user.dart';

class CartProvider with ChangeNotifier {
  final String authToken;
  final User user;

  CartProvider(this.authToken, this.user);

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems {
    return [..._cartItems];
  }

  void addCartItem(Product product) {
    var cartItem = _cartItems.length > 0
        ? _cartItems.firstWhere(
            (ci) => (ci.productId != null
                ? (ci.productVarId != null
                    ? ((ci.productVarId == product.fkItemVariantID &&
                            ci.productId == product.itemID) &&
                        ci.unitID == product.fkUnitID)
                    : (ci.productId == product.itemID &&
                        ci.unitID == product.fkUnitID))
                : ci.deaID == product.dealID),
            orElse: () => null)
        : null;
    if (cartItem == null) {
      var discount = product.allowedDiscount == true
          ? (product.salePrice * (product.discount / 100))
          : 0.0;
      var tax = product.isTaxable == true
          ? (product.salePrice * (product.taxRate / 100))
          : 0.0;
      _cartItems.add(CartItem(
          Guid.newGuid,
          product.name,
          product.itemID,
          product.fkItemVariantID,
          1,
          product.salePrice,
          product.salePrice,
          product.allowedDiscount,
          product.discount,
          discount,
          product.isTaxable,
          product.taxRate,
          tax,
          product.dealID,
          product.fkUnitID,
          (product.salePrice - discount + tax)));
    } else {
      updateCartItemQty(cartItem, (cartItem.qty + 1));
    }

    notifyListeners();
  }

  CartItem selectedCartItem;
  void updateSelectedCartItem(CartItem cartItem) {
    selectedCartItem = cartItem;
    numpadAmount = cartItem.qty.toString();

    notifyListeners();
  }

  bool isCartItemSelected(Guid cartItemId) {
    return selectedCartItem != null && selectedCartItem.id == cartItemId;
  }

  String numpadAmount = '';
  void updateNumpadValue(String value, {bool override = false}) {
    if (override) {
      numpadAmount = '';
    }
    switch (value) {
      case 'up':
        double amount = double.parse(numpadAmount);
        amount += 1;
        numpadAmount = amount.toString();
        break;
      case 'down':
        double amount = double.parse(numpadAmount);
        amount -= 1;
        numpadAmount = amount.toString();
        break;
      case 'delete':
        if (selectedCartItem != null) {
          _cartItems.removeWhere((c) => c.id == selectedCartItem.id);
          clearCartItemSelection();
        }
        break;
      case 'ok':
        if (selectedCartItem != null) {
          updateCartItemQty(selectedCartItem, double.parse(numpadAmount));
          clearCartItemSelection();
        }
        break;
      case '.':
        var hasDot = numpadAmount.contains(value);
        if (!hasDot) {
          numpadAmount += value;
        }
        break;
      case 'backspace':
        numpadAmount = numpadAmount.length > 0
            ? numpadAmount.substring(0, numpadAmount.length - 1)
            : '';
        break;
      default:
        numpadAmount += value;
        break;
    }
    notifyListeners();
  }

  void updateCartItemQty(CartItem cartItem, double qty) {
    _cartItems.forEach((ci) {
      if (ci.id == cartItem.id) {
        ci.qty = qty;
      }
    });
    // _cartItems.removeWhere((c) => c.id == cartItem.id);
    // _cartItems.add(CartItem(
    //   cartItem.id,
    //   cartItem.description,
    //   cartItem.productId,
    //   qty,
    //   cartItem.unitPrice,
    // ));
  }

  void clearCartItemSelection({bool notify = false}) {
    selectedCartItem = null;
    numpadAmount = '';

    if (notify) {
      notifyListeners();
    }
  }

  double get grandTotal {
    double total = 0.00;
    _cartItems.forEach((c) {
      total += c.qty * c.unitPrice;
    });
    return total;
  }

  bool _showProducts = true;
  String _searchQuery;
  Category _selectedCategory;
  List<Category> _categories = [];
  List<Product> _products = [];

  bool get showProducts {
    return _showProducts;
  }

  List<Category> get categories {
    if (_searchQuery == null || _searchQuery.isEmpty) {
      return _categories;
    }
    var products = _products
        .where((p) =>
            p.name.contains(_searchQuery) || p.itemNoStr.contains(_searchQuery))
        .toList();
    if (products.length > 0) {
      print('Products: ${products.length}');
      var cats = _categories
          .where((c) => products.any((p) => p.categoryId == c.id))
          .toList();
      print('Categories: ${cats.length}');
      return cats;
    }
    return _searchQuery != null
        ? _categories.where((c) => c.name.contains(_searchQuery)).toList()
        : _categories;
  }

  List<Product> getProductByCategory(String categoryId) {
    if (_searchQuery == null || _searchQuery.isEmpty) {
      return _products.where((p) => p.categoryId == categoryId).toList();
    }
    return _products
        .where((p) =>
            p.categoryId == categoryId &&
            (p.name.contains(_searchQuery) ||
                p.itemNoStr.contains(_searchQuery)))
        .toList();
  }

  String getParentCategories(String categoryId) {
    String parentTree = '';
    if (_categories.length > 0) {
      var cat =
          _categories.firstWhere((c) => c.id == categoryId, orElse: () => null);
      if (cat.parentId != null) {
        var parent = _categories.firstWhere((c) => c.id == cat.parentId,
            orElse: () => null);
        if (parent != null) {
          parentTree += ' > ${parent.name}' + getParentCategories(parent.id);
        }
      }
    }
    return parentTree;
  }

  Future<void> populateProducts() async {
    var url = '${Constants.baseUrl}api/v1/product/getcartproductcatalog';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          // 'Content-Type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case HttpStatus.ok:
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;
          final List<Category> loadedCategories = [];
          final List<Product> loadedProducts = [];
          if (extractedData != null) {
            var categories = extractedData['categories'] as List<dynamic>;
            if (categories != null) {
              categories.forEach((value) {
                var cat = Category(
                  value['id'].toString(),
                  value['name'].toString(),
                  value['parentId'] != null
                      ? value['parentId'].toString()
                      : null,
                );
                loadedCategories.add(cat);
              });
            }
            _categories = loadedCategories;
            loadedCategories.forEach((cat) {
              cat.parentTree = getParentCategories(cat.id);
            });
            var products = extractedData['products'] as List<dynamic>;
            if (products != null) {
              products.forEach((value) {
                Product prod =
                    Product.fromJson((value as Map<String, dynamic>));
                loadedProducts.add(prod);
              });
            }
          }
          _categories = loadedCategories;
          _products = loadedProducts;
          break;
        case HttpStatus.forbidden:
          break;
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Category get selectedCategory {
    return _selectedCategory;
  }

  set selectedCategory(value) {
    _selectedCategory = value;
  }

  bool isCategorySelected(String categoryId) {
    return _selectedCategory != null && _selectedCategory.id == categoryId;
  }

  void updateSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void filterCategories(String query) {
    _searchQuery = query;
    _selectedCategory = null;
    notifyListeners();
  }
}
