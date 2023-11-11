import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/components/cart_item.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/utils/price_utils.dart';

class CartProducts extends StatefulWidget {
  final List<CartModel> cartProducts;

  const CartProducts({super.key,  required this.cartProducts });

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List<CartModel> cartProducts = [];

  _CartProductsState();

  @override
  void initState() {
    super.initState();
    setState(() {
      cartProducts = widget.cartProducts;
    });
  }

  void _popNavigatorBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _updateCartProduct(CartModel updatedProduct) {
    setState(() {
      cartProducts = cartProducts.map((product) {
        if (product.id == updatedProduct.id) {
          product.ammounts = updatedProduct.ammounts;
          return product;
        } 
        
        return product;
      }).toList();
    });
  }

  void _deleteCartProduct(CartModel deletedProduct) {
    setState(() {
      int index = cartProducts.indexWhere((product) => product.id == deletedProduct.id);
      cartProducts.removeAt(index);
    });
  }

  int _getTotalPrice() {
    List<int> priceList = cartProducts.map((product) => product.price * product.ammounts).toList();
    int totalPrice = 0;
    if (priceList.isNotEmpty) {
      totalPrice = priceList.reduce((accumulator, price) => accumulator + price);
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  heading(),
                  body()
                ]
              ),
            ),
            footer()
          ],
        )
      )
    );
  }

  Widget heading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
          child: Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffdedede),
                  offset: Offset(0, 2.0),
                  blurRadius: 8.0
                )
              ]
            ),
            child: const Icon(CupertinoIcons.back),
          ),
          onPressed: () {
            _popNavigatorBack(context);
          }
        ),
        Column(
          children: [
            Text(
              'Keranjang',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSans3(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xff404040)
              )
            ),
            Text('${cartProducts.length} barang',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSans3(
                fontSize: 20.0,
                color: const Color(0xff595959)
              )
            ),
            const SizedBox(height: 25.0),
          ]
        ),
        CupertinoButton(child: Container(), onPressed: () {})
      ]      
    );
  }

  Widget body() {
    return Expanded(
      child: ListView(
        children: cartProducts.map((product) =>
          CartItem(
            product: product,
            onAmmountsChanged: _updateCartProduct,
            onItemDeleted: _deleteCartProduct,
          )
        ).toList(),
      ),
    );
  }

  Widget footer() {
    return Container(
      child: Column(
        children: [
          const DottedLine(
            dashColor: Color(0xff8e8e8e),
            dashLength: 10.0,
            lineThickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total'),
                Text('IDR ${PriceUtils.formatPrice(_getTotalPrice())} K', style: const TextStyle(
                  fontWeight: FontWeight.bold
                ))
            ]),
          ),
          CupertinoButton(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff272727),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffdedede),
                      offset: Offset(0, 8.0),
                      blurRadius: 20.0
                    )
                  ]
                ),
                child: const Text(
                  'Check Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)
                )
              )
            ),
            onPressed: () {},
          )
        ],
      )
    );
  }
}