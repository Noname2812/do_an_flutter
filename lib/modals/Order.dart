import 'dart:convert';

import 'package:do_an/modals/Product.dart';

class Order {
  final String? id;
  final String? orderCode;
  final String? customerName;
  final String? customerPhone;
  final String? customerCode;
  final String? customerEmail;
  final List<dynamic>? products;
  final String? paymentMethod;
  final String? deliveryAddress;
  final String? deliveryDate;
  final String? deliveryFee;
  final String? totalPrice;
  final String? totalPaid;
  final String? totalProductPrice;
  final String? voucherCode;
  final String? voucherDiscount;
  final String? note;
  final String? status;
  final String? reasonCancel;
  final String? createdAt;
  final String? updatedAt;
  Order({
    this.id,
    this.orderCode,
    this.customerName,
    this.customerPhone,
    this.customerCode,
    this.customerEmail,
    this.products,
    this.paymentMethod,
    this.deliveryAddress,
    this.deliveryDate,
    this.deliveryFee,
    this.totalPrice,
    this.totalPaid,
    this.totalProductPrice,
    this.voucherCode,
    this.voucherDiscount,
    this.note,
    this.status,
    this.reasonCancel,
    this.createdAt,
    this.updatedAt,
  });

  Order copyWith({
    String? id,
    String? orderCode,
    String? customerName,
    String? customerPhone,
    String? customerCode,
    String? customerEmail,
    List<ProductOrder>? products,
    String? paymentMethod,
    String? deliveryAddress,
    String? deliveryDate,
    String? deliveryFee,
    String? totalPrice,
    String? totalPaid,
    String? totalProductPrice,
    String? voucherCode,
    String? voucherDiscount,
    String? note,
    String? status,
    String? reasonCancel,
    String? createdAt,
    String? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerCode: customerCode ?? this.customerCode,
      customerEmail: customerEmail ?? this.customerEmail,
      products: products ?? this.products,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      totalPrice: totalPrice ?? this.totalPrice,
      totalPaid: totalPaid ?? this.totalPaid,
      totalProductPrice: totalProductPrice ?? this.totalProductPrice,
      voucherCode: voucherCode ?? this.voucherCode,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
      note: note ?? this.note,
      status: status ?? this.status,
      reasonCancel: reasonCancel ?? this.reasonCancel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Order.fromMap(dynamic map) {
    return Order(
      id: map['_id'].toString() as String?,
      orderCode: map['orderCode'].toString() as String?,
      customerName: map['customerName'].toString() as String?,
      customerPhone: map['customerPhone'].toString() as String?,
      customerCode: map['customerCode'].toString() as String?,
      customerEmail: map['customerEmail'].toString() as String?,
      products: (map['products']).map((e) => ProductOrder.fromJson(e)).toList()
          as List<dynamic>,
      paymentMethod: map['paymentMethod'].toString() as String?,
      deliveryAddress: map['deliveryAddress'].toString() as String?,
      deliveryDate: map['deliveryDate'].toString() as String?,
      deliveryFee: map['deliveryFee'].toString() as String?,
      totalPrice: map['totalPrice'].toString() as String?,
      totalPaid: map['totalPaid'].toString() as String?,
      totalProductPrice: map['totalProductPrice'].toString() as String?,
      voucherDiscount: map['voucherDiscount'].toString() as String?,
      voucherCode: map['voucherCode'].toString() as String?,
      note: map['note'].toString() as String?,
      status: map['status'].toString() as String?,
      reasonCancel: map['reasonCancel'].toString() as String?,
      createdAt: map['createdAt'].toString() as String?,
      updatedAt: map['updatedAt'].toString() as String?,
    );
  }
}
