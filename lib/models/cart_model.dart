import 'package:store_app/models/product_model.dart';

class CartModel extends ProductModel {
  @override
  bool isFavorite;
  int selectedSize;
  int ammounts;

  CartModel({ 
    required String id,
    required String name,
    required String image,
    required String description,
    required int price,
    required List<int> sizes,
    this.isFavorite = false,
    this.selectedSize = -1,
    this.ammounts = 1 
  }) : super(
    id: id, 
    name: name, 
    description: description,
    image: image, 
    price: price, 
    sizes: sizes,
    isFavorite: isFavorite
  );
}