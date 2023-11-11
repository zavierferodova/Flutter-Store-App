import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/components/shop_item.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/views/cart_products.dart';
import 'package:store_app/views/detail_product.dart';

class HomeFragment extends StatefulWidget {
  final List<ProductModel> products;
  final List<CartModel> cartProducts;
  final void Function(List<ProductModel>) onProductsChanged;
  final void Function(CartModel) onCartAdded;

  const HomeFragment({super.key, 
    required this.products,
    required this.cartProducts,
    required this.onProductsChanged,
    required this.onCartAdded
  });

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<ProductModel> products = [];
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      products = widget.products;
    });
  }
  
  void _setFavorite(ProductModel favoriteProduct) {
    setState(() {
      products = products.map((product) {
        if (product.id == favoriteProduct.id) {
          product.isFavorite = favoriteProduct.isFavorite;
        }

        return product;
      }).toList();

      widget.onProductsChanged(products);
    });
  }

  void _navigateDetailPage(BuildContext context, ProductModel product) async {
    var result = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return DetailProduct(product: product);
    }));

    if (result != null) {
      if (result is CartModel) {
        _setFavorite(ProductModel(
            id: result.id,
            image: result.image,
            name: result.name,
            price: result.price,
            description: result.description,
            sizes: result.sizes,
            isFavorite: result.isFavorite
          )
        );

        widget.onCartAdded(result);
      } else {
        _setFavorite(result);
      }
    }
  }

  void _navigateCartPage(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return CartProducts(cartProducts: widget.cartProducts);
    }));
  }

  void _setSearchValue(String value) {
    setState(() {
      searchValue = value;
    });
  }

  List<ProductModel> _getListProducts() {
    if (searchValue != '') {
      return products.where((product) => product.name.toLowerCase().contains(searchValue.toLowerCase())).toList();
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Produk',
                    style: GoogleFonts.sourceSans3(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff404040)
                    )
                  ),
                  Transform.translate(
                    offset: const Offset(14, 0),
                    child: CupertinoButton(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xff666AF6),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 5),
                              color: Color(0xff9598f9),
                              blurRadius: 8.0
                            )
                          ]
                        ),
                        child: const Icon(
                          CupertinoIcons.cart, 
                          color: Colors.white
                        )
                      ),
                      onPressed: () {
                        _navigateCartPage(context);
                      }
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              CupertinoSearchTextField(
                onChanged: _setSearchValue
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth < 900) {
                        return GridView.count(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.79,
                          children: _getListProducts().map((product) {
                            return GestureDetector(
                              onTap: () { 
                                _navigateDetailPage(context, product); 
                              },
                              child: ShopItem(
                                product: product,
                                onFavoriteChanged: _setFavorite
                              )
                            );
                          }).toList(),
                        );
                      }

                      return GridView.count(
                        crossAxisCount: 6, 
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 4,
                        childAspectRatio: 0.79,
                        children: _getListProducts().map((product) {
                          return GestureDetector(
                            onTap: () { 
                              _navigateDetailPage(context, product); 
                            },
                            child: ShopItem(
                              product: product,
                              onFavoriteChanged: _setFavorite
                            )
                          );
                        }).toList(),
                      );
                    }
                  )
                )
              )
            ]
          ),
        )
      )
    );
  }
}