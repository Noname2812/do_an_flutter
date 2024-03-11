import 'dart:convert';
import 'package:do_an/api/productApi.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(
    String email, String password, String param) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/auth/$param',
  );
  final res =
      await http.post(url, body: {"email": email, "password": password});
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result;
  } else if (res.statusCode == 404) {
    final result = jsonDecode(res.body);
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}
