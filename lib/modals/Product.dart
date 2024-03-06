class Product {
  String image, name, id;
  int minprice, maxPrice;
  Product(
      {required this.image,
      required this.name,
      required this.minprice,
      required this.id,
      required this.maxPrice});
  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
        name: data['name'],
        minprice: data['minPrice'],
        maxPrice: data['maxPrice'],
        id: data['_id'],
        image: data['images'][0]);
  }
}
