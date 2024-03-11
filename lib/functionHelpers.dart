import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Image base64ToImage(String base64) {
  return Image.memory(
    const Base64Decoder().convert(base64.split(',').last),
    fit: BoxFit.fill,
  );
}

ImageProvider<Object> base64ToImageObject(String base64) {
  return MemoryImage(const Base64Decoder().convert(base64.split(',').last));
}

String formatMoney(double money) {
  final oCcy = NumberFormat("#,###", "en_US");
  return oCcy.format(money);
}
