import 'dart:convert';
import 'package:do_an/api/authApit.dart';
import 'package:do_an/api/cartApi.dart';
import 'package:do_an/api/notification.dart';
import 'package:do_an/api/requestGet.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Notification.dart';
import 'package:do_an/modals/Order.dart';
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

int caculatorCart(List<ItemCart> list) {
  var total = 0;
  for (var element in list) {
    total += element.totalPrice!;
  }
  return total;
}

String? keyExists(Set<Map<String, String>> data, String key, String value) {
  for (final element in data) {
    if (element.containsKey(key) && element[key] == value) {
      return element[key]!;
    }
  }
  return null;
}

Map<String, String> getBarcode(
    List<dynamic> data, String option1, String option2) {
  final product = data.firstWhere((item) =>
      item['option1'] == option1 && item['option2'] == option2 ||
      item['option1'] == option2 && item['option2'] == option1);
  if (product == null) {
    return {};
  }
  return {'barcode': product['barcode'], "price": product['price'].toString()};
}

String getValueByKey(Set<Map<String, String>> data, String key) {
  for (final map in data) {
    if (map.containsKey(key)) {
      return map[key]!;
    }
  }
  return "-1";
}

Future<List<ItemCart>> getCartByUser(String userID) async {
  final resultCart = await getCart(userID);
  return (resultCart["carts"] as List<dynamic>)
      .map((item) => ItemCart.fromJson(item))
      .toList();
}

Future<List<Order>> getOrderByUser(String userID) async {
  final result = await getOrder(userID);
  return (result["orders"] as List<dynamic>)
      .map((item) => Order.fromMap(item))
      .toList();
}

Future<List<NotificationUser>> getNotificationByUser(String userID) async {
  final result = await getNotification(userID);
  return (result["data"] as List<dynamic>)
      .map((item) => NotificationUser.fromMap(item))
      .toList();
}

String convertDateTime(String dateTimeStr) {
  DateTime datetimeObj = DateTime.parse(dateTimeStr).toUtc();
  return DateFormat('dd/MM/yyyy').format(datetimeObj);
}
