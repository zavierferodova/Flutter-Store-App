import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/utils/price_utils.dart';

class CartItem extends StatefulWidget {
  final CartModel product;
  final void Function(CartModel) onAmmountsChanged;
  final void Function(CartModel) onItemDeleted;
  const CartItem({super.key,  required this.product, required this.onAmmountsChanged, required this.onItemDeleted });

  @override
  _CartItemState createState() => _CartItemState(itemAmmount: product.ammounts);
}

class _CartItemState extends State<CartItem> {
  int itemAmmount;

  _CartItemState({ required this.itemAmmount });

  void _incrementAmmount() {
    if (itemAmmount == 99) {
      setState(() {
        itemAmmount = 99;
        widget.product.ammounts = itemAmmount;
        widget.onAmmountsChanged(widget.product);
      });
    } else {
      setState(() {
        itemAmmount++;
        widget.product.ammounts = itemAmmount;
        widget.onAmmountsChanged(widget.product);
      });
    }
  }

  void _decrementAmmount() {
    if (itemAmmount == 1) {
      setState(() {
        itemAmmount = 1;
        widget.product.ammounts = itemAmmount;
        widget.onAmmountsChanged(widget.product);
      });
    } else {
      setState(() {
        itemAmmount--;
        widget.product.ammounts = itemAmmount;
        widget.onAmmountsChanged(widget.product);
      });
    }
  }

  void _deleteItem(CartModel product) {
    widget.onItemDeleted(product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffdedede),
            offset: Offset(0, 8.0),
            blurRadius: 20.0
          )
        ]
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    widget.product.image
                  )
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.product.name + ((widget.product.selectedSize > -1) ? ' - Size ${widget.product.selectedSize}' : ''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff373737)
                      )
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      'IDR ${PriceUtils.formatPrice(widget.product.price)} K',
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff0ecc16)
                      )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CupertinoButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: _incrementAmmount,
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: const Color(0xffb5b5b5)),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.black,
                                      size: 14.0,
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Text(
                                    itemAmmount.toString(), 
                                    style: GoogleFonts.roboto()
                                  )
                                ),
                                CupertinoButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: _decrementAmmount,
                                  child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0, color: const Color(0xffb5b5b5)),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.black,
                                      size: 14.0,
                                    )
                                  ),
                                ),
                              ]
                            ),
                            CupertinoButton(
                              child: const Icon(
                                CupertinoIcons.trash, 
                                color: Colors.redAccent,
                                size: 20.0
                              ), 
                              onPressed: () {
                                _deleteItem(widget.product);
                              }
                            )
                          ]
                        ),
                      ),
                    )
                  ]
                )
              ),
            )
          ]
        )
      ) 
    );
  }
}
