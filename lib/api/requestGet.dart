import 'dart:convert';
import 'package:http/http.dart' as http;

class MethodGet {
  final String param;
  final String? skip;
  final String? limit;
  MethodGet({required this.param, this.skip, this.limit});
}

Future<Map<String, dynamic>> requestMethodGet(MethodGet param) async {
  final url = Uri.http(BASE_URL_LOCAL, '/v2${param.param}',
      {"skip": param.skip ?? 0, "limit": param.limit ?? 10});
  final res = await http.get(url);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}

const IP = "192.168.0.104";
const BASE_URL_LOCAL = "$IP:8000";
