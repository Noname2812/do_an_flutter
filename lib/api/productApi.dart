import 'dart:convert';
import 'package:do_an/api/requestGet.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchAll(String endpoint) async {
  final url = Uri.http(BASE_URL_LOCAL, '/v2$endpoint');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getDetailProduct(String id) async {
  final url = Uri.http(BASE_URL_LOCAL, '/v2/product/$id');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getProductsByQuery(
    String param, int offset) async {
  final url = Uri.http(BASE_URL_LOCAL, '/v2/product$param',
      {"skip": offset.toString(), "limit": "10"});
  final res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body) as Map<String, dynamic>;
  } else {
    throw Exception("Call api falied !");
  }
}
