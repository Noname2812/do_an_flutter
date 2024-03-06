import 'dart:convert';
import 'package:do_an/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchAll(String endpoint) async {
  final url = Uri.https(BASE_URL, '/v2$endpoint');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

Future<Map<String, dynamic>> getDetailProduct(String id) async {
  final url = Uri.https(BASE_URL, '/v2/product/$id');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}
