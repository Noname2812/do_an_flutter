import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchAll(String endpoint) async {
  final url = Uri.https(
      'do-an-web-be-git-main-top1808s-projects.vercel.app', '/v2$endpoint');
  final res = await http.get(url);
  if (res.statusCode == 200) {
    final result = jsonDecode(res.body) as Map<String, dynamic>;
    return result;
  } else {
    throw Exception("Call api falied !");
  }
}
