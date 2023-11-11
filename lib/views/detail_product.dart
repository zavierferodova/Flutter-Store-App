import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/utils/price_utils.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel product;

  const DetailProduct({super.key,  required this.product });

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int itemAmmount = 1;
  int selectedSize = -1;

  @override
  void initState() {
    super.initState();
  }

  void _popNavigatorBack(BuildContext context, ProductModel product) {
    Navigator.pop(context, product);
  }

  void _popWithCartData(BuildContext context, ProductModel product) {
    Navigator.pop(context, CartModel(
      id: product.id,
      name: product.name,
      image: product.image,
      description: product.description,
      price: product.price,
      sizes: product.sizes,
      isFavorite: product.isFavorite,
      ammounts: itemAmmount,
      selectedSize: selectedSize
    ));
  }

  void _setFavoriteProduct() {
    setState(() {
      widget.product.isFavorite = !widget.product.isFavorite;
    });
  }

  void _incrementAmmount() {
    if (itemAmmount == 99) {
      setState(() {
        itemAmmount = 99;
      });
    } else {
      setState(() {
        itemAmmount++;
      });
    }
  }

  void _decrementAmmount() {
    if (itemAmmount == 1) {
      setState(() {
        itemAmmount = 1;
      });
    } else {
      setState(() {
        itemAmmount--;
      });
    }
  }

  int _getTotalPrice() {
    return widget.product.price * itemAmmount;
  }

  void _setSelectedSize(int size) {
    if (selectedSize == size) {
      setState(() {
        selectedSize = -1;
      });
    } else {
      setState(() {
        selectedSize = size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _popNavigatorBack(context, widget.product);
        return true;
      },
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: [
              heading(context),
              body(),
              footer(context)
            ]
          )
        )
      )
    );
  } 

  Widget heading(BuildContext context) {
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
            _popNavigatorBack(context, widget.product);
          }
        ),
        Text(
          'Detail Produk',
          style: GoogleFonts.sourceSans3(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xff404040)
          ),
        ),
        CupertinoButton(
          onPressed: _setFavoriteProduct,
          child: Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffdedede),
                  offset: Offset(0, 2.0),
                  blurRadius: 8.0
                )
              ]
            ),
            child: Icon(
              widget.product.isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: Colors.redAccent
            ),
          )
        ),
      ]
    );
  }

  Widget body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover
                  )
                )
              ),
              const SizedBox(height: 25.0),
              Text(
                widget.product.name,
                style: GoogleFonts.roboto(
                  color: const Color(0xff393939),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 15.0),
              Text('Ukuran', style: GoogleFonts.roboto(
                  color: const Color(0xff737373),
                )
              ),
              const SizedBox(height: 6.0),
              SizedBox(
                height: 55.0,
                child: ListView(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  scrollDirection: Axis.horizontal,
                  children: widget.product.sizes.map((size) {
                    return GestureDetector(
                      onTap: () {
                        _setSelectedSize(size);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10.0
                        ),
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                          left: 14.0,
                          right: 14.0
                        ),
                        decoration: BoxDecoration(
                          color: (selectedSize == size) ? const Color(0xff666AF6) : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffdedede),
                              offset: Offset(0, 2.0),
                              blurRadius: 8.0
                            )
                          ]
                        ),
                        child: Text(
                          size.toString(),
                          style: GoogleFonts.roboto(
                            color: (selectedSize == size) ? Colors.white : const Color(0xff626262)
                          )
                        )
                      )
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 15.0),
              Text('Jumlah', style: GoogleFonts.roboto(
                  color: const Color(0xff737373),
                )
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(0.0), 
                    onPressed: _incrementAmmount,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffdedede),
                            offset: Offset(0, 2.0),
                            blurRadius: 8.0
                          )
                        ]
                      ),
                      child: const Icon(
                        CupertinoIcons.plus,
                        color: Color(0xff393939),
                        size: 20.0
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Text(
                      itemAmmount.toString(), 
                      style: GoogleFonts.roboto(
                        color: const Color(0xff626262)
                      )
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: _decrementAmmount,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffdedede),
                            offset: Offset(0, 2.0),
                            blurRadius: 8.0
                          )
                        ]
                      ),
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Color(0xff393939),
                        size: 20.0
                      )
                    )
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Text('Deskripsi', style: GoogleFonts.roboto(
                  color: const Color(0xff737373),
                )
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.only(
                  top: 14.0,
                  bottom: 14.0,
                  left: 18.0,
                  right: 18.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffdedede),
                      offset: Offset(0, 2.0),
                      blurRadius: 8.0
                    )
                  ]
                ),
                child: Text(
                  widget.product.description, style: GoogleFonts.roboto(
                    color: const Color(0xff626262),
                    fontSize: 16.0
                  )
                ),
              )
            ],
          )
        )
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
        left: 20.0,
        right: 20.0
      ),
      decoration: const BoxDecoration(
        color: Color(0xff121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harga',
                style: GoogleFonts.roboto(
                  color: const Color(0xffbebebe),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0
                )
              ),
              Text(
                'IDR ${PriceUtils.formatPrice(_getTotalPrice())} K',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0
                ),
              ),
            ],
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              padding: const EdgeInsets.only(
                left: 22.0,
                right: 22.0,
                top: 18.0,
                bottom: 18.0
              ),
              decoration: BoxDecoration(
                color: const Color(0xff666AF6),
                borderRadius: BorderRadius.circular(14.0)
              ),
              child: Row(
                children: [
                  Text(
                    'Keranjang  ',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.cart_fill,
                    color: Colors.white,
                    size: 20.0
                  )
                ]
              ),
            ), 
            onPressed: () {
              _popWithCartData(context, widget.product);
            }
          )
        ],
      ),
    );
  }
}