// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:do_an/modals/Cart.dart';
import 'package:http/http.dart' as http;

import 'package:do_an/api/requestGet.dart';

Future<Map<String, dynamic>> getCart(String id) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/cart/',
  );
  final res = await http.get(url, headers: {"userid": id});
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<http.Response> addToCart(ParamAddToCart params, String userId) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/cart/add-to-cart',
  );

  final res =
      await http.post(url, body: params.toMap(), headers: {"userId": userId});
  return res;
}

Future<http.Response> deleteItemCart(String cartID) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/cart/$cartID',
  );
  final res = await http.delete(url);
  return res;
}

Future<http.Response> editCart(String cartID, String quantity) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/cart/$cartID',
  );
  final res = await http.put(url, body: {"quantity": quantity.toString()});
  return res;
}

Future<http.Response> payment(ParamPayment p) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/cart/pay',
  );
  final res =
      await http.post(url, body: p.toMap(), headers: {"userId": p.userID});
  return res;
}
