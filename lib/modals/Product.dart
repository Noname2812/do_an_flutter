class Product {
  String name, id;
  int minprice, maxPrice;
  List<dynamic> images;
  Product(
      {required this.images,
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

class GroupOptions {
  String groupName;
  List<String> options;
  String id;
  GroupOptions(
      {required this.groupName, required this.id, required this.options});
  factory GroupOptions.fromJson(Map<String, dynamic> json) {
    return GroupOptions(
        groupName: json['groupName'], id: json['id'], options: json['options']);
  }
}
