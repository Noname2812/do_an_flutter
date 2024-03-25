import 'dart:convert';

class Voucher {
  final String? id;
  final String? code;
  final String? name;
  final String? type;
  final int? value;
  final int? maxDiscountValue;
  final int? minOrderValue;
  final String? description;
  final int? quantity;
  final int? quantityUsed;
  final int? quantityLeft;
  final String? dateStart;
  final String? dateEnd;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  Voucher({
    this.id,
    this.code,
    this.name,
    this.type,
    this.value,
    this.maxDiscountValue,
    this.minOrderValue,
    this.description,
    this.quantity,
    this.quantityUsed,
    this.quantityLeft,
    this.dateStart,
    this.dateEnd,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Voucher copyWith({
    String? id,
    String? code,
    String? name,
    String? type,
    int? value,
    int? maxDiscountValue,
    int? minOrderValue,
    String? description,
    int? quantity,
    int? quantityUsed,
    int? quantityLeft,
    String? dateStart,
    String? dateEnd,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Voucher(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      maxDiscountValue: maxDiscountValue ?? this.maxDiscountValue,
      minOrderValue: minOrderValue ?? this.minOrderValue,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      quantityUsed: quantityUsed ?? this.quantityUsed,
      quantityLeft: quantityLeft ?? this.quantityLeft,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Voucher.fromMap(dynamic map) {
    return Voucher(
      id: map['_id'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      value: map['value'].toInt() as int,
      maxDiscountValue: map['maxDiscountValue'].toInt() as int,
      minOrderValue: map['minOrderValue'].toInt() as int,
      description: map['description'] as String,
      quantity: map['quantity'].toInt() as int,
      quantityUsed: map['quantityUsed'].toInt() as int,
      quantityLeft: map['quantityLeft'].toInt() as int,
      dateStart: map['dateStart'] as String,
      dateEnd: map['dateEnd'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
  factory Voucher.fromJson(String source) =>
      Voucher.fromMap(json.decode(source) as Map<String, dynamic>);
}
