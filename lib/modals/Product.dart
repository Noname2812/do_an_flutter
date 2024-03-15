class Product {
  String name, id;
  int minprice, maxPrice;
  List<dynamic> images;
  String? quantity;
  Product(
      {required this.images,
      this.quantity,
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
        images: data['images']);
  }
}

class ProductOrder {
  String? productCode, productName, note, productImage;
  String? price, quantity, totalPrice;
  ProductOrder(
      {this.note,
      this.productImage,
      this.price,
      this.productCode,
      this.productName,
      this.quantity,
      this.totalPrice});
  factory ProductOrder.fromJson(dynamic data) {
    return ProductOrder(
      note: data['note'].toString(),
      productImage: data['productImage'].toString(),
      productCode: data['productCode'].toString(),
      productName: data['productName'].toString(),
      price: data['price'].toString(),
      quantity: data['quantity'].toString(),
      totalPrice: data['totalPrice'].toString(),
    );
  }
}

class DetailProduct extends Product {
  DetailProduct(
      {required super.images,
      required super.name,
      required super.minprice,
      required super.id,
      required super.maxPrice,
      this.categoryID,
      this.description,
      this.groupOptions,
      this.productSKUList,
      this.productSKUBarcodes});
  DetailProduct.constructor()
      : super(images: [], name: '', minprice: 0, id: '', maxPrice: 0);
  String? description;
  List<dynamic>? categoryID;
  List<dynamic>? groupOptions;
  List<dynamic>? productSKUBarcodes;
  List<dynamic>? productSKUList;

  factory DetailProduct.fromJson(Map<String, dynamic> data) {
    return DetailProduct(
      id: data["_id"],
      images: data["images"],
      maxPrice: data["maxPrice"],
      description: data["description"],
      categoryID: data["categoryIds"],
      minprice: data["minPrice"],
      groupOptions: data["groupOptions"],
      name: data["name"],
      productSKUBarcodes: data["productSKUBarcodes"],
      productSKUList: data['productSKUList'],
    );
  }
}
