import 'dart:convert';

import 'package:do_an/api/requestGet.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getNotification(String id) async {
  final url = Uri.http(
    BASE_URL_LOCAL,
    '/v2/notification',
  );
  final res = await http.get(url, headers: {"userId": id});
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body);
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}
