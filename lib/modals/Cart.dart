// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an/modals/Product.dart';

class ItemCart {
  final String? id;
  final String? customerId;
  final DetailProduct? product;
  final String? productSKUBarcode;
  final int? price;
  final int? promotionPrice;
  final int? quantity;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final dynamic productSKU;
  ItemCart({
    this.id,
    this.customerId,
    this.product,
    this.productSKUBarcode,
    this.price,
    this.promotionPrice,
    this.quantity,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.productSKU,
  });

  ItemCart copyWith({
    String? id,
    String? customerId,
    DetailProduct? product,
    String? productSKUBarcode,
    int? price,
    int? promotionPrice,
    int? quantity,
    int? totalPrice,
    String? createdAt,
    String? updatedAt,
    dynamic productSKU,
  }) {
    return ItemCart(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      product: product ?? this.product,
      productSKUBarcode: productSKUBarcode ?? this.productSKUBarcode,
      price: price ?? this.price,
      promotionPrice: promotionPrice ?? this.promotionPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productSKU: productSKU ?? this.productSKU,
    );
  }

  factory ItemCart.fromJson(Map<String, dynamic> map) {
    return ItemCart(
      id: map['_id'] as String,
      customerId: map['customerId'] as String,
      product: DetailProduct.fromJson(map["product"]),
      productSKUBarcode: map['productSKUBarcode'] as String,
      price: map['price'].toInt() as int,
      promotionPrice: map['promotionPrice'].toInt() as int,
      quantity: map['quantity'].toInt() as int,
      totalPrice: map['totalPrice'].toInt() as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      productSKU: map['productSKU'] as Map<String, dynamic>,
    );
  }
  factory ItemCart.init() {
    return ItemCart();
  }
  @override
  String toString() {
    return 'Cart(id: $id, customerId: $customerId, product: $product, productSKUBarcode: $productSKUBarcode, price: $price, promotionPrice: $promotionPrice, quantity: $quantity, totalPrice: $totalPrice, createdAt: $createdAt, updatedAt: $updatedAt,  productSKU: $productSKU)';
  }

  @override
  bool operator ==(covariant ItemCart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.customerId == customerId &&
        other.product == product &&
        other.productSKUBarcode == productSKUBarcode &&
        other.price == price &&
        other.promotionPrice == promotionPrice &&
        other.quantity == quantity &&
        other.totalPrice == totalPrice &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.productSKU == productSKU;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        product.hashCode ^
        productSKUBarcode.hashCode ^
        price.hashCode ^
        promotionPrice.hashCode ^
        quantity.hashCode ^
        totalPrice.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        productSKU.hashCode;
  }
}

class ParamAddToCart {
  String productId;
  String barcode;
  String price;
  String quantity;
  ParamAddToCart(
      {required this.barcode,
      required this.quantity,
      required this.price,
      required this.productId});

  Map<String, dynamic> toMap() {
    return <String, String>{
      'productId': productId,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
    };
  }
}

class ParamPayment {
  String userID;
  String customerName,
      customerPhone,
      customerEmail,
      paymentMethod,
      deliveryAddress;
  String? deliveryFee;
  List<ItemCart> products;
  ParamPayment(
      {required this.userID,
      required this.products,
      required this.customerName,
      required this.customerPhone,
      required this.customerEmail,
      required this.paymentMethod,
      required this.deliveryAddress,
      this.deliveryFee});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deliveryFee': deliveryFee ?? "0",
      "totalProductPrice": "0",
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'products': json.encode(products
          .map((e) => {
                "productImage": e.product?.images[0],
                "cartId": e.id ?? "",
                "productName": e.product?.name,
                "productCode": e.product?.id,
                "quantity": e.quantity.toString(),
                "price": e.price.toString(),
                "totalPrice": (e.quantity! * e.price!).toString(),
                "note": '',
              })
          .toList()),
      'paymentMethod': paymentMethod,
    };
  }
}
