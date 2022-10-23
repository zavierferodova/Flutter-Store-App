import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/utils/price_utils.dart';

class FavoriteItem extends StatelessWidget {
  final ProductModel product;

  FavoriteItem({ required this.product });

  @override
  Widget build(BuildContext context) {
    return Container(      
      child: Container(
        margin: EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0, bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xffdedede),
              offset: Offset(0, 8.0),
              blurRadius: 20.0
            )
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  product.image
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff373737)
                      )
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      'IDR ${PriceUtils.formatPrice(product.price)} K',
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0ecc16)
                      )
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ]
                )
              ),
            )
          ]
        )
      ),
    );
  }
}
