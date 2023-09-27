import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/providers/cart_provider.dart';

class CartDesktopCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildProducts(CartProvider provider, String categoryId) {
      var products = provider.getProductByCategory(categoryId);
      return products.length > 0
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                return FittedBox(
                  child: InkWell(
                    onTap: () =>
                        Provider.of<CartProvider>(context, listen: false)
                            .addCartItem(products[i]),
                    child: Container(
                      height: 100,
                      width: 300,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Constants.colorGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        products[i].name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            products[i].salePrice.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Text('No products');
    }

    return Consumer<CartProvider>(
      builder: (ctx, provider, _) {
        var cats = provider.categories;
        if (provider.selectedCategory == null) {
          provider.selectedCategory = cats.length > 0 ? cats[0] : null;
        } else if (cats.length <= 0) {
          provider.selectedCategory = null;
        }
        return cats.length > 0
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: ListView.builder(
                        itemCount: cats.length,
                        itemBuilder: (_, i) {
                          bool flag = provider.isCategorySelected(cats[i].id);
                          return Container(
                            child: flag
                                ? Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Constants.colorPurpleDark,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        cats[i].name,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    // padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: InkWell(
                                      onTap: () => Provider.of<CartProvider>(
                                        context,
                                        listen: false,
                                      ).updateSelectedCategory(cats[i]),
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Constants.colorGrey,
                                            ),
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Text(cats[i].name),
                                          subtitle: Text(provider
                                              .categories[i].parentTree),
                                          // subtitle: Text(provider
                                          //     .getParentCategories(provider
                                          //         .categories[i].parentId)),
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: provider.selectedCategory != null
                          ? _buildProducts(
                              provider, provider.selectedCategory.id)
                          : Container(
                              child: Center(
                                child: Text('Please select category'),
                              ),
                            ),
                    ),
                  )
                ],
              )
            : Text('No result found');
      },
    );
  }
}
