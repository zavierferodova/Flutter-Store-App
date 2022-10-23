class ProductModel {
  String id;
  String image;
  String name;
  int price;
  String description;
  List<int> sizes;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.sizes,
    this.isFavorite = false
  });
}
